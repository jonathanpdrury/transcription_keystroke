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
