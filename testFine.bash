#!/bin/bash
if [ $# -lt 5 ]; then
  echo "$0 modelDir testFile lexeltFile savePath index.sense"
  exit
fi
if (set -u; : $WSDHOME) 2> /dev/null
then
  bdir=$WSDHOME
else
  bdir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
fi
ldir=$bdir/lib
modelDir=$1
testFile=$2
lexeltFile=$3
savePath=$4
senseIndex=$5
CLASSPATH=$ldir/weka-3.2.3.jar:$ldir/jwnl.jar:$ldir/commons-logging.jar:$ldir/jdom.jar:$ldir/trove.jar:$ldir/maxent-2.4.0.jar:$ldir/opennlp-tools-1.3.0.jar:$ldir/liblinear-1.33-with-deps.jar:$bdir/ims.jar
#mkdir -p $savePath
export LANG=en_US
java -mx2500m -cp $CLASSPATH sg.edu.nus.comp.nlp.ims.implement.CTester -ptm $ldir/tag.bin.gz -tagdict $ldir/tagdict.txt -ssm $ldir/EnglishSD.bin.gz -prop $ldir/prop.xml -c sg.edu.nus.comp.nlp.ims.corpus.CAllWordsFineTaskCorpus -r sg.edu.nus.comp.nlp.ims.io.CAllWordsResultWriter -is $senseIndex $testFile $modelDir $modelDir $savePath -f sg.edu.nus.comp.nlp.ims.feature.CAllWordsFeatureExtractorCombination -e sg.edu.nus.comp.nlp.ims.classifiers.CLibLinearEvaluator -lexelt $lexeltFile
