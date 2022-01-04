* 下次读 `3.9 Secondary Expansion`





* makefile 重新生成

  这部分没遇到，想象不出示例

* 





`sed` 修改 `html` 路径。

```bash
sed 's/https:\/\/www.gnu.org\/software\/make\/manual\/make.html/file:\/\/\/home\/yuchao\/Downloads\/make\/GNU make.html/g' GNU\ make.html > GNU\ make_changed.html
```





makefile 解析步骤：

* 读取一个逻辑行
* 删除注释
* 如果该行是`recipe` ，将其添加到当前的`recipe` 中，读取下一行
* 展开该行的元素
* 扫描行中的分割符，决定该行是分配还是规则
* 内化操作结果并读取下一行







