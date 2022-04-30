#!/bin/bash

supported_array=("8" "11" "10" "9" "20.04" "18.04" "16.04")

startup_function(){
    echo " ____    __    ____  ___      .______      .______             ______  __       __  "
    echo " \   \  /  \  /   / /   \     |   _  \     |   _  \           /      ||  |     |  | "
    echo "  \   \/    \/   / /  ^  \    |  |_)  |    |  |_)  |  ______ |  ,----'|  |     |  | "
    echo "   \            / /  /_\  \   |      /     |   ___/  |______||  |     |  |     |  | "
    echo "    \    /\    / /  _____  \  |  |\  \---- |  |              |  ----.||   ----.|  | "
    echo "     \__/  \__/ /__/     \__\ | _| ._____| | _|               \______||_______||__| "
    echo ""
    echo " warp-cli bash created by 0xb4dc0d3x"

}

checkwarp_function() {
    echo ""
    echo " check for warp=on or warp=off to make sure warp is connected or not"
    curl -s https://www.cloudflare.com/cdn-cgi/trace/ >> checkwarp.txt
    source checkwarp.txt
    echo " $warp"
}

connect_function(){
    echo " $(warp-cli enable-always-on)"
    checkwarp_function
    main_function
}

disconnect_function(){
    echo " $(warp-cli disconnect)"
    checkwarp_function
    main_function
}

installing_function(){
    if [ $(uname -m) == "x86_64" ]; then
        echo " Supported"
        echo " Finding your version of OS"
        for i in "${supported_array[@]}"
        do
            # echo $i
            if [[ $(grep 'VERSION_ID' /etc/os-release) == *"$i"* ]]; then
                echo " Found"
                if [[ $(grep 'VERSION_ID' /etc/os-release) == *"11"* ]] || [[ $(grep 'VERSION_ID' /etc/os-release) == *"10"* ]] || [[ $(grep 'VERSION_ID' /etc/os-release) == *"9"* ]] || [[ $(grep 'VERSION_ID' /etc/os-release) == *"20.04"* ]] || [[ $(grep 'VERSION_ID' /etc/os-release) == *"18.04"* ]] || [[ $(grep 'VERSION_ID' /etc/os-release) == *"16.04"* ]]; then
                    curl https://pkg.cloudflareclient.com/pubkey.gpg | sudo gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
                    case $i in
                        11) 
                            $(echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ bullseye main' | sudo tee /etc/apt/sources.list.d/cloudflare-client.list) 
                            sudo apt update ;
                            sudo apt install cloudflare-warp ;;
                        10) 
                            $(echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ buster main' | sudo tee /etc/apt/sources.list.d/cloudflare-client.list) ;;
                            sudo apt update ;
                            sudo apt install cloudflare-warp ;;
                        9) 
                            $(echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ stretch main' | sudo tee /etc/apt/sources.list.d/cloudflare-client.list) ;;
                            sudo apt update ;
                            sudo apt install cloudflare-warp ;;
                        20.04) 
                            $(echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ focal main' | sudo tee /etc/apt/sources.list.d/cloudflare-client.list) ;;            
                            sudo apt update ;
                            sudo apt install cloudflare-warp ;;
                        18.04) 
                            $(echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ bionic main' | sudo tee /etc/apt/sources.list.d/cloudflare-client.list) ;;
                            sudo apt update ;
                            sudo apt install cloudflare-warp ;;
                        16.04) 
                            $(echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ xenial main' | sudo tee /etc/apt/sources.list.d/cloudflare-client.list) ;;
                            sudo apt update ;
                            sudo apt install cloudflare-warp ;;
                        *)
                            echo "something went wrong" ;;
                    esac
                else
                    rpm -ivh https://pkg.cloudflareclient.com/cloudflare-release-el8.rpm
                    sudo yum install cloudflare-warp
                fi
            fi
        done
    fi    
}

main_function(){
    echo ""
    echo " Hello, welcome warp-cli bash controller"
    echo " if you are not installed warp-cli press 2"
    echo " press 0 to connect"
    echo " press 1 to disconnect"
    echo " press 9 to exit"

    read -p " " input

    if [ $input -eq 0 ]; then
        echo " you want to connect to warp"
        connect_function

    elif [ $input -eq 1 ]; then
        echo " you want to disconnect from warp"
        disconnect_function

    elif [ $input -eq 2 ]; then
        echo " installing warp-cli"
        installing_function

    elif [ $input -eq 9 ]; then
        echo ' exiting...'
        exit

    else
        echo " wrong operation"
        echo " 0, 1, 2 and 9 are valid"
        main_function

    fi
}

startup_function
echo ""
main_function
