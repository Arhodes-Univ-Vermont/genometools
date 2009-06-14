#!/bin/sh

if test $# -ne 1
then
  echo "Usage: $0 [small|all]"
  exit 1
fi

if test $1 = 'small'
then
  regularfiles="at1MB ecoli1 ecoli2 swiss1MB"
else
  regularfiles="at1MB ecoli1 ecoli2 swiss1MB yeast dmel human2"
fi

repetitivefiles=mfd

code2file()
{
  case $1 in
    at1MB)
      echo "testdata/at1MB";;
    mfd)
      echo "${HOME}/seqcmpprojects/MouthFootDisease/mfdallpart.fna.gz";;
    yeast)
      echo "${HOME}/seqcmpprojects/yeast/yeast.fna.gz";;
    human2)
      echo "${PROJECT}/biodata/genomes/H_sapiens-build36.54-2009/Homo_sapiens.NCBI36.54.dna.chromosome.02.fa.gz";;
    dmel)
      echo "${HOME}/seqcmpprojects/d_mel/d_mel.fna.gz";;
    ecoli1)
      echo "${PROJECT}/biodata/genomes/Bacteria/Ecoli/ecoli.fna";;
    ecoli2)
      echo "${PROJECT}/biodata/genomes/Bacteria/Ecoli_O157_H7/AE005174.fna";;
    swiss1MB)
      echo "${GTTESTDATA}/swissprot/swiss1MB";;
    *)
      echo "$0: illegal filecode $1"
      exit 1;;
  esac
}

checkregular()
{
  filename=$1
  for cfc in ${regularfiles}
  do
    if test ${cfc} = ${filename}
    then
      return 0
    fi
  done
  return 1
}

suffixerator()
{
  fc=$1
  filename=`code2file $1`
  shift
  printf "# RUN $fc $*\n"
  ${RUNNER} gt suffixerator -showtime -indexname sfx-id -tis -suf -db ${filename} $* | egrep '# TIME overall|# space peak'
}

for rfc in $regularfiles  $repetitivefiles
do
  fn=`code2file ${rfc}`
  if test ! -f ${fn}
  then
    echo "FAILURE: ${fn} does not exist"
    exit 1
  fi
done

echo "# DATE `date +%Y-%m-%d-%H:%M`"
for rfc in $regularfiles $repetitivefiles
do
  checkregular ${rfc}
  if test $? -eq 0
  then
    suffixerator ${rfc} -cmpcharbychar ""
    suffixerator ${rfc} ""
  fi
  for dc in 32 128 256
  do
    suffixerator ${rfc} -cmpcharbychar -dc ${dc}
    suffixerator ${rfc} -dc ${dc}
  done
  rm -f sfx-idx.*
done
