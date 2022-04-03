#!/bin/bash

# wrong() {
#     echo "press 0 to connect"
#     echo "press 1 to disconnect"
#     echo ""
#     read inputInWrongFunc

#     if [ $inputInWrongFunc -eq 0 ]; then
#         echo "connecting to warp"
#         connect_function

#     elif [ $inputInWrongFunc -eq 1 ]; then
#         echo "disconnecting from warp"
#         disconnect_function

#     else
#        echo 'bad operation, Try again!'
#        wrong
#     fi
# }
#
# what_to_do_next(){
#    echo 'ok done that whats next'
#    echo '0 to connect.'
#    echo '1 to disconnect.'
#    read operation
# }

checkWarp() {
    echo "check for warp=on or warp=off to make sure warp is connected or not"
    curl https://www.cloudflare.com/cdn-cgi/trace/
}

connect_function(){
    warp-cli connect
    checkWarp
    main_function
}

disconnect_function(){
    warp-cli disconnect
    checkWarp
    main_function
}

register_function(){
    warp-cli register
    main_function
}

main_function(){
echo "Hello, welcome warp-cli bash controller"
echo "if you are not registered to warp-cli press 2"
echo "press 0 to connect"
echo "press 1 to disconnect"
echo "press 9 to exit"

read input

if [ $input -eq 0 ]; then
    echo "you want to connect to warp"
    connect_function

elif [ $input -eq 1 ]; then
    echo "you want to disconnect from warp"
    disconnect_function

elif [ $input -eq 2 ]; then
    echo "registeing to warp-cli"
    register_function

elif [ $input -eq 9 ]; then
    echo 'exiting...'
    exit

else
    echo "wrong operation"
    echo "0, 1, 2 and 9 are valid"
    main_function

fi
}
main_function