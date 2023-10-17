# loop on systems
for i in `seq 1 9`
do
 # get dir
 dir=`sed -n ${i}p list | awk '{print $1}'`
 # get PDB
 pdb=`sed -n ${i}p list | awk '{print $2}'`
 # get MAP
 map_u=`sed -n ${i}p list | awk '{print $3}'`
 map_l=`echo $map_u | awk '{print tolower($1)}' | sed -e "s/-/_/g"`
 # go into directory 
 cd ${dir}/0-Pdb-Map
 # download PDB and MAP 
 wget https://files.rcsb.org/download/${pdb}.pdb  
 wget https://ftp.ebi.ac.uk/pub/databases/emdb/structures/${map_u}/map/${map_l}.map.gz
 # uncompress map
 gunzip ${map_l}.map.gz
 # go back to root
 cd ../../
done
