#!/bin/bash
    
    export CERTORAKEY=$1
    
    echo "export CERTORAKEY=\$CERTORAKEY" >> ~/.bashrc
    
    source ~/.bashrc
    
    echo "Certora key has been set up."
    
