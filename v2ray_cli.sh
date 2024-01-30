#!/bin/bash
cur_dir=$(pwd)
cfg_path=/home/yzk/.config/v2ray
subscription_path=${cfg_path}/subscriptions

cd ${subscription_path}

# Get list of .json files in specified directory
files=(*.json)

select file in "${files[@]}"; do
    if [[ $REPLY == "0" ]]; then
        echo 'Bye!' >&2
        exit
    elif [[ -z $file ]]; then
        echo 'Invalid choice, try again' >&2
    else
        break
    fi
done

echo $file

cd ..

echo $(pwd)

ln -svf subscriptions/"$file" ${cfg_path}/config.json

systemctl --user restart v2ray.service

cd $cur_dir

echo "SOCKS5 PORT = 20170"
echo "HTTP   PORT = 20171"

systemctl --user status v2ray.service
