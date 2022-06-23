#1.设置终端代理
export http_proxy=http://127.0.0.1:7890
export https_proxy=http://127.0.0.1:7890


# 2.使用curl google.com测试是否连通
curl google.com


#3.禁用设置的镜像源
unset FLUTTER_STORAGE_BASE_URL;
unset PUB_HOSTED_URL;


# 4.检查是否可上传
# flutter packages pub publish --dry-run --server=https://pub.dartlang.org


# 5.上传
flutter packages pub publish --server=https://pub.dartlang.org