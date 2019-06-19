##This script depends on the packages 'tictoc' and 'keypress', the latter of which will not work in the GUI version of R; so this should be run in a terminal window.

#To begin recording, type transcription_keystroke() in an R window. You will then be prompted for a logfile name. Once you've entered a logfile name,
#You will be prompted to hit "Enter" to begin recording. Once you do hit "enter", the recording begins and you can press keys as you wish
#To end the recording, press 'x'
#Once you do so, a data frame will appear with the event timings, and a .csv file will be written to your working directory

#Feel free to get in touch if you have any questions

require(tictoc)
require(keypress)



transcription_keystroke<-function(){

filename=readline(prompt = "Input logfile name...")

tic.clearlog()
key.vec<-vector()

counter=1
x=counter
while(x!=letters[24]){
	
	if(counter==1){
		print("Press <Enter> to begin recording...")
		x=keypress()
		if(x=="enter"){
		tic()
		print("RECORDING BEGUN")
		} else{
		stop("First key must be <Enter>")
		}
	counter=counter+1
	}
	
	x=keypress()
	print(x)
	key.vec<-c(key.vec,x)
	toc(log=TRUE)
	tic()
	}
	

log.lst <- tic.log(format = FALSE)
timings <- unlist(lapply(log.lst, function(x) x$toc - x$tic))

output<-data.frame(event=key.vec,elapsed=timings,cumulative=cumsum(timings),filename=filename)
eval(parse(text=paste0("write.csv(output,file='",filename,".csv')")))
return(output)
}
