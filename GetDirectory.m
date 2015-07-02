function Directory=GetDirectory(DirectoryPath)

M=importdata([DirectoryPath, 'Directory.xlsx'])
M
M.textdata
M=M.textdata


Directory=M(:,1)


end
