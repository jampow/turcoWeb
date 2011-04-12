#!/bin/bash

task=$(zenity --list \
  --title="Escolha a tarefa" \
  --column="tarefa" --column="descrição" \
  "Mover para admin" "Move arquivos do scaffold para dentro da pasta admin" \
  "Limpar" "Limpa ./script/generate errado" \
  "svn_add_all" "Adiciona todos os novos arquivos ao SVN" \
  "grep-svn" "grep excluindo diretórios .svn" \
  "teste" "teste")


#====PRIMEIRA OPÇÃO (MOVER PARA ADMIN)==========================================

if [ "$task" == 'Mover para admin' ]
then
  what=$(zenity --entry --title="Digite o plural do que será movido.")

  if zenity --question --text="Deseja abrir os arquivos para edição?"
  then
    abrir="s"
  else
    abrir="n"
  fi

  from=("app/views/"$what \
        "app/controllers/"$what"_controller.rb" \
        "app/helpers/"$what"_helper.rb" \
        "test/functional/"$what"_controller_test.rb" \
        "test/unit/helpers/"$what"_helper_test.rb")

  to=("app/views/admin/" \
      "app/controllers/admin/" \
      "app/helpers/admin/" \
      "test/functional/admin/" \
      "test/unit/helpers/admin/")

  newarc=("app/views/admin/"$what"/*" \
      "app/controllers/admin/"$what"_controller.rb" \
      "app/helpers/admin/"$what"_helper.rb" \
      "test/functional/admin/"$what"_controller_test.rb" \
      "test/unit/helpers/admin/"$what"_helper_test.rb")

  type=("-d" \
        "-e" \
        "-e" \
        "-e" \
        "-e")

  tabs=("\t\t\t\t" \
        "\t" \
        "\t\t" \
        "\t" \
        "\t")

  x=0

  while [ $x != ${#from[@]} ]
  do

    if [ ${type[$x]} ${from[$x]} ]
    then
      echo -e "\e[33;1m${from[$x]}\e[m${tabs[$x]} --> \e[34;1m${to[$x]}\e[m"
      mv ${from[$x]} ${to[$x]}
    else
      echo -e "\e[33;1m${from[$x]}\e[m${tabs[$x]} \e[31;1mNÃO EXISTE\e[m"
    fi

    if [ "$abrir" == 's' ]
    then
      gedit ${newarc[$x]}
    fi

    let "x = x + 1"
  done

  echo
  echo -e "\e[36;1mAltere o arquivo conf/routes.rb\e[m"
fi

#=====SEGUNDA OPÇÃO (DESFAZER COMANDO ERRADO)===================================

if [ "$task" == 'Limpar' ]
then
  generate=$(zenity --list \
    --title="Qual generate foi rodado" \
    --column="./script/generate ____?" \
    "controller" \
    "model" \
    "scaffold")

  echo $generate

  case $generate in
    controller)
       selector=( true \
                  true \
                  true \
                  true \
                  true \
                  false \
                  false \
                  false \
                  false \
                  false )

      sin=$(zenity --entry --title="SINGULAR" --text="Singular")
      plu=$sin
    ;;
    model)
       selector=( false \
                  false \
                  false \
                  false \
                  false \
                  false \
                  true \
                  true \
                  true \
                  true )

      sin=$(zenity --entry --title="SINGULAR" --text="Singular")
      plu=$(zenity --entry --title="PLURAL" --text="Plural" --entry-text=$sin"s")
    ;;
    scaffold)
       selector=( true \
                  true \
                  true \
                  true \
                  true \
                  true \
                  true \
                  true \
                  true \
                  true )

      sin=$(zenity --entry --title="SINGULAR" --text="Singular")
      plu=$(zenity --entry --title="PLURAL" --text="Plural" --entry-text=$sin"s")
    ;;
    *)
      echo "Você tem de entrar com um parâmetro válido"
    ;;
  esac


  locales=( "app/views/"$plu \
            "app/controllers/"$plu"_controller.rb" \
            "app/helpers/"$plu"_helper.rb" \
            "test/functional/"$plu"_controller_test.rb" \
            "test/unit/helpers/"$plu"_helper_test.rb" \
            "app/views/layouts/"$plu".html.erb" \
            "app/models/"$sin".rb" \
            "test/unit/"$sin"_test.rb" \
            "test/fixtures/"$plu".yml" \
            "db/migrate/*_create_"$plu"*.rb")

  type=("-d" \
        "-e" \
        "-e" \
        "-e" \
        "-e" \
        "-e" \
        "-e" \
        "-e" \
        "-e" \
        "-e" )

  x=0

  while [ $x != ${#locales[@]} ]
  do

    if [ ${selector[$x]} = true ]
    then
      if [ ${type[$x]} ${locales[$x]} ]
      then
        echo -e "\e[33;1m${locales[$x]}\e[m${tabs[$x]} --> \e[34;1mREMOVIDO\e[m"
        if [ ${type[$x]} = "-d" ]
        then
          rm -r ${locales[$x]}
        else
          rm ${locales[$x]}
        fi
      else
        echo -e "\e[33;1m${locales[$x]}\e[m${tabs[$x]} \e[31;1mNÃO EXISTE\e[m"
      fi
    fi

    let "x = x + 1"
  done

fi

#=====TERCEIRA OPÇÃO (Adiciona todos os novos arquivos ao SVN)==================

if [ "$task" == 'svn_add_all' ]
then
  svn status | grep -v "^.[ \t]*\..*" | grep "^?" | awk '{print $2}' | xargs svn add
fi

#=====QUARTA OPÇÃO (grep sem diretórios .svn)====================================

if [ "$task" == 'grep-svn' ]
then

  pattern=$(zenity --entry --title="Busca" --text="texto procurado")
  location=$(zenity --file-selection --directory --title="Aonde será feita a busca?")

  now=$(pwd)

  #replace $now inside $location value for nothing
  relative=${location/$now\//}

  grep -rin $pattern $relative | grep -v '/\.svn/'

fi

#=====QUINTA OPÇÃO (teste)=======================================================

if [ "$task" == 'teste' ]
then

  teste=true

  if [ $teste = true ]
  then
    echo "true"
  else
    echo "false"
  fi

fi

