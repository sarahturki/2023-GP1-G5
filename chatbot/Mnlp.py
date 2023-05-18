import re
from camel_tools.utils.dediac import dediac_ar
from camel_tools.utils.normalize import normalize_unicode
from camel_tools.tokenizers.word import simple_word_tokenize
from camel_tools.disambig.mle import MLEDisambiguator
from camel_tools.tagger.default import DefaultTagger
from camel_tools.tokenizers.morphological import MorphologicalTokenizer

#sentence = "ﷺ"
sentence = "هلْ ذَهَبْتَ إِلَى مَكْتَبَة الرياض؟"
#sentence= "فتنفستَ الصعَداء"
#sentence= 'مُوَظَّف'
#sentence = "اكل"
#sentence = "ذهخبت الى المكتبه ؟"

## removing  .,\'-؟:!; 
 
if __name__ == '__main__':
 
    s = sentence
 
    s = re.sub(r'[.,"\'-؟:!;]', '', s)
 
####################################################################
## removing  haracat 

sent_dediac = dediac_ar(s)

####################################################################
#Normalizition

# Normalize characters like 'ﷺ' 
sent_norm = normalize_unicode(sent_dediac)



####################################################################
###Morphological Tokenization 
##  
# The tokenizer expects pre-tokenized text
sentence2 = simple_word_tokenize(sent_norm)
print('Before Morphological Tokenization:',sentence2)

# Load a pretrained disambiguator to use with a tokenizer
mle = MLEDisambiguator.pretrained('calima-msa-r13')

# We can output diacritized tokens by setting `diac=True`
tokenizer = MorphologicalTokenizer(disambiguator=mle, scheme='bwtok', split=True)
tokens = tokenizer.tokenize(sentence2)
print("Morphological Tokenization:",tokens)

####################################################################


#Tagging (Grammar rules)
tagger = DefaultTagger(mle, 'pos')

#Tagging (Grammar rules)
pos_tags = tagger.tag(tokens)

print("Tagging:",pos_tags)

  

################################################################################

