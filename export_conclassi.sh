echo "Inserire il nome del progetto: "
read project

# Controllo argomento obbligatorio: NAMESPACE
if [ -z $project ]
then
        echo "Devi inserire il nome del progetto!"
        exit
else
	mkdir $project
	cd $project
fi

. ../classi/buildconfigs.h

buildconfigs $project
