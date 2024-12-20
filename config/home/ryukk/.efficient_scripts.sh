
funtion dirDiff() {
if [ $# -ne 2 ]; then
    echo "Usage: $0 directory1 directory2"
    exit 1
fi

dir1=$1
dir2=$2

if [ ! -d "$dir1" ] || [ ! -d "$dir2" ]; then
    echo "Both parameters should be directories."
    exit 1
fi

for file in "$dir1"/*; do
    filename=$(basename "$file")
    if [ -f "$dir2/$filename" ]; then
        if ! diff "$file" "$dir2/$filename" > /dev/null; then
            echo "Difference found in file: $filename"
        fi
    else
        # echo "No matching file for $filename in $dir2"
    fi
done

}

function jqq(){
    unformat=$1"unformat.json"
    mv $1 $unformat
    jq . $unformat &>| $1
    rm -f $unformat
}

function decompress(){
	7z x $1
}

function compress(){
	7z a -mmt $1.7z $1 
}

# git 
function stashAllFile(){
	git stash push -u $(git status --porcelain | awk '{print $2}' | rg -v 'gitignore')
}

# kill vscode server
function killvscode(){
 	ps aux |grep .vscode-server |awk '{print $2}' |xargs kill
}
