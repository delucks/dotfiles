" Basic test with CrunchLine command and variables

" Load the test data. 
edit crunchLine002.in

"this test fails without this next line
normal gg 

call search('pow')
.CrunchLine

" Save the processed buffer contents 
call vimtest#SaveOut()
call vimtest#Quit()


