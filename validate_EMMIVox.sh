# validation scripts (available here https://github.com/COSBlab/EMMIVox)
# set to correct location
PHENIX=/c7/home/mbonomi/build/EMMIVox/tutorials/1-refinement/5-Analysis/do_PHENIX
CCMASK=/c7/home/mbonomi/build/EMMIVox/scripts/cryo-EM_validate.py
# loop on systems
for i in `seq 1 9`
do
 # get dir
 dir=`sed -n ${i}p list | awk '{print $1}'`
 # get PDB
 pdb=`sed -n ${i}p list | awk '{print $2}'`
 # get MAP
 map=`sed -n ${i}p list | awk '{print tolower($3)}' | sed -e "s/-/_/g"`
 # get resolution
 res=`sed -n ${i}p list | awk '{print $4}'`
 # go into EMMIVox root dir 
 cd ${dir}/3-Model
 # loop over cc cutoffs
 for cc in cc-0.7 cc-0.8 cc-0.9 cc-1.0
 do
   # go into subdir
   cd $cc
   # run PHENIX
   bash $PHENIX conf_EMMIVOX.pdb ../../0-Pdb-Map/${map}.map $res > results.EMMIVOX
   # and cryo-EM_validate
   python $CCMASK ../../0-Pdb-Map/${map}.map --pdbA=conf_EMMIVOX.pdb --threshold=0.0 > CCmask.EMMIVOX 
   # go back
   cd ../
 done 
 # go back to root
 cd ../../
done
