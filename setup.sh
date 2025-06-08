#Setup evil in custom packages
echo "only run in your emacs config directory"

echo "current working directory:  `pwd`"

echo "press y to continue "

read r























echo "Setting emacs packages"

package_dir='custom-packages'

if [ ! -d "$package_dir" ];
then
    echo "create folder $package_dir"
    mkdir $package_dir
else
    echo "$package_dir exists"
fi



if [  -d "$package_dir" ];
then
  
    echo "Setting up packages"
    cd $package_dir

    echo "========================================================="


    echo "Package setup complete"

    cd ..

    echo "========================================================="

    echo ""
    echo ""

else
    echo "Packages could not be setup"
fi














echo "Setup utilities"

echo "========================================================="


util_dir='custom-utils'

if [ ! -d "$util_dir" ];
then
    echo "create folder $util_dir"
    mkdir $util_dir
else
    echo "$util_dir exists"
fi

echo ""

if [ ! -d "$util_dir" ];
then
    cd $util_dir

    echo "Setup Groovy language server"

    git clone https://github.com/GroovyLanguageServer/groovy-language-server.git

    echo "Util setup complete"

    cd ..

    echo "========================================================="


else
    echo "Utils could not be setup"
 fi
