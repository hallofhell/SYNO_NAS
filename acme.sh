#!/bin/bash

# 域名

DOMAIN='your domain'
#your domain=你申请的域名，不要删掉''
# # DNS类型，dns_ali dns_dp dns_gd dns_aws dns_linode根据域名服务商而定，CloudFlare就是dns_cf

DNS='dns_ali'
#按照自己的域名提供商选择，详细参照acme官方文档
#https://github.com/acmesh-official/acme.sh/wiki/%E8%AF%B4%E6%98%8E
#https://github.com/acmesh-official/acme.sh/wiki/dnsapi

# DNS API 生效等待时间 值(单位：秒)，一般120即可

# 某些域名服务商的API生效时间较大，需要将这个值加大(比如900)

DNS_SLEEP=120

# 证书服务商，zerossl 和 letsencrypt，我使用letsencrypt，使用zerossl还需要注册

CERT_SERVER='letsencrypt'

generateCrtCommand="acme.sh --force --keylength 4096 --log --issue --server ${CERT_SERVER} --dns ${DNS} --dnssleep ${DNS_SLEEP} -d "${DOMAIN}" -d "*.${DOMAIN}"" 
#群辉系统低版本貌似不支持ecc证书，加个keylength 4096（秘钥长度）强制申请RSA证书
installCrtCommand="acme.sh --deploy --home  . -d "${DOMAIN}" -d "*.${DOMAIN}" --deploy-hook synology_dsm"
#化重点！网上的说明TMD没有加--home  .这个指令指定目录，害我每次都是申请完之后部署失败，白折腾了一个休息日
#最好随便新建一个默认证书用于替换，保留群辉默认自签证书
docker exec neilpang-acme.sh1 $generateCrtCommand

docker exec neilpang-acme.sh1 $installCrtCommand
