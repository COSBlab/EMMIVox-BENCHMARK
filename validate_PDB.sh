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
 # go into PDB directory 
 cd ${dir}/0-Pdb-Map
 # run PHENIX
 bash $PHENIX ${pdb}.pdb ${map}.map $res > results.PDB
 # and cryo-EM_validate 
 python $CCMASK ${map}.map --pdbA=${pdb}.pdb --threshold=0.0 > CCmask.PDB
 # go back to root
 cd ../../
done
