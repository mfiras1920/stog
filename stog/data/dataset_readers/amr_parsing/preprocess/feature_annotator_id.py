import stanza
from collections import Counter, defaultdict
from Sastrawi.Stemmer.StemmerFactory import StemmerFactory
from utils.ner.entity_recognizer import get_entities

class FeatureAnnotator:
    word_dict = {}
    
    def __init__(self, params):
        self.nlp = stanza.Pipeline(lang="id",use_gpu=True,verbose=False, tokenize_pretokenized=True)
        factory = StemmerFactory()
        self.stemmer = factory.create_stemmer()
        self.ner = get_entities
        self.params = params
        
        import nltk
        self.pos_tagger = nltk.tag.CRFTagger()
        self.pos_tagger.set_model_file(my_dir+'pretrained/pos_tagger/all_indo_man_tag_corpus_model.crf.tagger')
    def annotate(self, sentence):
        annotation = defaultdict(list)
        sentence = sentence.translate(str.maketrans('', '', string.punctuation))
        doc = self.nlp(sentence)
        
        annotation['ner_tags'] = self.ner(sentence)
        
        word_dict = defaultdict(int)
        
        for sent in doc.sentences:
            for idx, word in enumerate(sent.words):
                annotation['tokens'].append(word.text)
                stemmed_word = self.stemmer.stem(word.text)                
                if (annotation['ner_tags'][idx] in ['PER', 'ORG']):
                    stemmed_word = word.text.lower()
                word_dict[stemmed_word] += 1
                annotation['lemmas'].append(stemmed_word+'_{}'.format(word_dict[stemmed_word]))
                annotation['pos_tags'].append(word.upos)
                annotation['dependency'].append(dict(relation=word.deprel, head=word.head))
    
        if self.params['pos_tagger'] == 'nltk':
            annotation['pos_tags'] = [tag[1] for tag in self.pos_tagger.tag(annotation['tokens'])]
            
        
        return annotation