#!/usr/bin/env bash


pdir="/Users/junix/junix.github.io/_posts/2015"
post_name()
{
        dateprefix=$(date "+%Y-%m-%d")
        name=$1
        echo $pdir/${dateprefix}-${name}.md
}

if [[ $# -ne 1 ]];then
        echo "Usage: np Title"
        exit 1
fi
   

postname=$(post_name $1)
if [ ! -e $postname ]; then
        cp $pdir/template $postname
fi

vim $postname +3
