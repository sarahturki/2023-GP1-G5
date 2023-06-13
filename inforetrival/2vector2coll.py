import sqlite3
import pandas as pd
from nltk.tokenize import word_tokenize
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
import numpy as np
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import re
from arabic_reshaper import arabic_reshaper
from nltk.tokenize import word_tokenize
from bidi.algorithm import get_display

# Initialize Firebase  


cred = credentials.Certificate("ammommyfirebase-firebase-adminsdk-x9h73-b3d18864dc.json") ###private file , cannot be shared 
firebase_admin.initialize_app(cred)
db = firestore.client()

# Preprocessing function for Arabic text
def preprocess_arabic_text(text):
    # Remove diacritics
    text = re.sub(r'[\u064B-\u065F\u0640]', '', text)
    
    # Remove non-Arabic characters and punctuations
    text = re.sub(r'[^\u0600-\u06FF\s]', '', text)
    
    # Remove special characters and punctuation marks
    text = re.sub(r'[^\w\s]', '', text)
    
    # Tokenize the text
    tokens = word_tokenize(text)
    
    # Return preprocessed tokens as a list
    return tokens


# Read knowledge base from Firestore
knowledge_base_collection = db.collection('KB')
knowledge_base_docs = knowledge_base_collection.get()
knowledge_base_firestore = []
for doc in knowledge_base_docs:
    knowledge_base_firestore.append(doc.to_dict()['entry']) 

# Read weekly info from Firestore
weekly_info_collection = db.collection('weekly_Info')
weekly_info_docs = weekly_info_collection.get()
weekly_info_firestore = []
for doc in weekly_info_docs:
    weekly_info_firestore.append(doc.to_dict()['forMother'])
    weekly_info_firestore.append(doc.to_dict()['forBaby'])

# Preprocess knowledge base entries
knowledge_base_preprocessed = [preprocess_arabic_text(entry) for entry in knowledge_base_firestore]

# Preprocess weekly info data
weekly_info_preprocessed = [preprocess_arabic_text(entry) for entry in weekly_info_firestore]

# Combine knowledge base and weekly info
combined_data_preprocessed = knowledge_base_preprocessed + weekly_info_preprocessed

# Convert preprocessed data back to strings
combined_data_strings = [' '.join(tokens) for tokens in combined_data_preprocessed]

# Initialize TF-IDF vectorizer
vectorizer = TfidfVectorizer()
# Compute TF-IDF matrix
tfidf_matrix = vectorizer.fit_transform(combined_data_strings)

# Create a SQLite database
conn = sqlite3.connect('KB.db')
c = conn.cursor()

# Create a table to store the knowledge base entries
c.execute('''CREATE TABLE IF NOT EXISTS KB
             (entry_id INTEGER PRIMARY KEY AUTOINCREMENT,
              entry_text TEXT,
              tfidf_embedding BLOB)''')
# Insert the knowledge base entries and their embeddings into the database
for i, entry_text in enumerate(combined_data_strings):
    # Check if entry already exists in the database
    c.execute("SELECT entry_text FROM KB WHERE entry_text = ?", (entry_text,))
    existing_entry = c.fetchone()

    # If entry doesn't exist, insert it into the database
    if not existing_entry:
        entry_tfidf_embedding = tfidf_matrix[i].toarray()
        c.execute("INSERT INTO KB (entry_text, tfidf_embedding) VALUES (?, ?)",
                  (entry_text, entry_tfidf_embedding.tobytes()))

# Commit the changes and close the connection
conn.commit()
conn.close()

# User input
user_input = input("Enter your question: ")
user_input_preprocess = preprocess_arabic_text(user_input)

# Load the database and perform similarity search
conn = sqlite3.connect('KB.db')
c = conn.cursor()

# Compute the user input TF-IDF embedding
user_input_embedding = vectorizer.transform([' '.join(user_input_preprocess)]).toarray()

# Query the database for similar entries
c.execute("SELECT entry_text, tfidf_embedding FROM KB")
results = c.fetchall()
similarity_scores = []
for entry_text, entry_tfidf_embedding_bytes in results:
    entry_tfidf_embedding = np.frombuffer(entry_tfidf_embedding_bytes, dtype=np.float64).reshape(1, -1)
    similarity = cosine_similarity(user_input_embedding, entry_tfidf_embedding)[0][0]
    similarity_scores.append(similarity)

# Sort the results based on similarity scores
sorted_indices = sorted(range(len(similarity_scores)), key=lambda i: similarity_scores[i], reverse=True)
sorted_results = [(results[i][0], similarity_scores[i]) for i in sorted_indices]

# Print the top 10 matching entries
num_results = 40  # Number of results to display
top_results = sorted_results[:num_results]

for entry_text, similarity in top_results:
    # Reshape and display Arabic text correctly
    entry_text_display = get_display(arabic_reshaper.reshape(entry_text))
    
    print(f"Entry: {entry_text_display}")
    print(f"Similarity: {similarity}")  
    print()

# Close the connection
conn.close()
