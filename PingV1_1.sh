#! /usr/bin/env bash
echo "Data e hora do dia"
date
Test="$?"
count=0
filename=ip.txt
declare -a ips
ips=(`cat "$filename"`)
for (( i = 0 ; i < ${#ips[@]} ; i++))
do
  echo "Equipamento disponível [$i]: ${ips[$i]}"
done
sleep 3
menu () {
	while true $count != "0"
	do
		clear
		echo '''  
===================================================================
			SCRIPT DE TESTE
===================================================================

1)Testar todos os equipamentos
2)Testar equipamento específico
3)Adicionar equipamento
4)sair
		
===================================================================
			SCRIPT DE TESTE
===================================================================	
		'''
		echo "Digite a opção desejada: "
		read opcao
		clear
		case "$opcao" in

		1)
				echo "==================================================================="
				
				for ver1 in ${ips[@]:0:${#ips[@]}};
				do
					Test=`ping -c4 $ver1  | awk '$7 ~ /time/ {gsub("time=" , ""); print $7}'`
					if [ "$Test" > 0 ]; then
						echo "$ver1 está online"
					else
						echo "$ver1 está offline, favor verificar."
					fi
				done
				echo "==================================================================="
				sleep 3
				;;
		2)
				echo "==================================================================="
				for i in `echo ${!ips[*]}`; do 	echo "$i ==> ${ips[$i]}" 
				done 
				read -p "Digite o número do equipamento: " Eq
				clear
				for ver2 in ${ips[$Eq]};
				do 
					Test2=`ping -c4 $ver2  | awk '$7 ~ /time/ {gsub("time=" , ""); print $7}'`
					if [ "$Test2" > 0 ]; then
                                                  echo "$ver2 está online"
                                          else
                                                  echo "$ver2 está offline, favor verificar."
                                          fi
				
				done
				sleep 3				
				;;


		3)		echo "==================================================================="
				read -p "Digite o ip do equipamento: " ip
				ips+=( $ip )

			;;
		4)
			{ echo "${ips[*]}"; }>ip.txt
			echo "Obrigado por vir!"
			exit
;;
		*)
			echo "opção invalida"
		esac
		done

}
menu
