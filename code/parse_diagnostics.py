import xml.etree.ElementTree as ET
import numpy as np

coh_means = []

for i in range(100,900,100):
    tree = ET.parse('./results/fine-scale/mallet-models/UK/'+str(i)+'-topics-diagnostics.xml')
    root = tree.getroot()

    #mean coherence
    coh_means.append(np.mean([float(child.attrib['coherence']) for child in root]))

