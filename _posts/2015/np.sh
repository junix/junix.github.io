#!/usr/bin/env bash


pdir="/Users/junix/junix.github.io/_posts/2015"
post_name()
{
        dateprefix=$(date "+%Y-%m-%d")
        name=$1
        post=$pdir/${dateprefix}-${name}.md

        for cadidator in $(find $pdir -iregex ".*/....-..-..-$1.md"); do
             post=$cadidator
        done
        echo $post
}


edit()
{
        gvim $1 +3
        cdir=$(pwd)
        cd $pdir
        git add $pdir/*
        git commit -m "modify new post [$1]"
        git push
        cd $cdir
}

if [[ $# -ne 1 ]];then
        echo "Usage: np Title"
        exit 1
fi
   
postname=$(post_name $1)
if [ ! -e $postname ]; then
    cp $pdir/template $postname
fi

edit $postname

