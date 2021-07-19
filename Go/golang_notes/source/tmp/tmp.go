


var rmdirs []func()

for _, d := range tmpDirs() {
	dir := d
	os.MkdirAll(dir, 0755)
	rmdirs = append(rmdirs, fund() {
		os.RemoveAll(dir)
	})
}

for _. rmdir := range rmdirs {
	rmdir()
}

