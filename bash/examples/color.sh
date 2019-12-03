#!/bin/bash

# Language: bash
echo
T='RGB'
echo " B\F" {30..37}m" "
for BACK in {40..47}; do
    echo -en "  $BACK"
    for FORE in {30..37}m; do
        echo -en "\e[$BACK;$FORE $T \e[0m"
    done
    echo
done
echo

for MODE in 1 4 5 7 8; do
    echo " B\F" {30..37}";${MODE}m "
    for BACK in {40..47}; do
        echo -en "  $BACK"
        for FORE in {30..37}";${MODE}m"; do
            echo -en "\e[$BACK;$FORE  $T  \e[0m"
        done
        echo
    done
    echo
done

echo "F\B" {40..47}m" "
for FORE in {30..37}; do
    echo -en " $FORE"
    for BACK in {40..47}m; do
        echo -en "\e[$FORE;$BACK $T \e[0m"
    done
    echo
done
echo

for MODE in 1 4 5 7 8; do
    echo "F\B" {40..47}";${MODE}m "
    for FORE in {30..37}; do
        echo -en " $FORE"
        for BACK in {40..47}";${MODE}m"; do
            echo -en "\e[$FORE;$BACK  $T  \e[0m"
        done
        echo
    done
    echo
done
