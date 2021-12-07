'''
Created on Jun 9, 2021

@author: phuls
'''

def reading_file(name):
    a=[]
    with open(name,"r") as f:
        content=f.read().splitlines()
    for i in range(0,len(content),1):
        if(content[i][0]!=content[i][4]):
            a.append(content[i])
    return a        
def writing_file(filename,data):
    with open(filename,"w") as f:
        for p in range(0,len(data),1):
            k=data[p].split(",")
#	    d1=[k[0],k[1],k[2],k[3],k[4],k[5],k[6]]
	    d1=[k[0],k[1],k[2],k[3],k[4],k[5],k[6],k[7],k[8]]	
#	    d1=[k[0],k[1],k[2],k[3],k[4]]
#	    d1=[k[0],k[1],k[2]]	
            d1=(str(d1).replace("[",""))
            d1=(str(d1).replace("]",""))
            d1=(str(d1).replace("'",""))
            f.write(str(d1))
            f.write("\n")
        f.close()    
        
print("Saksham")    
a1=reading_file("concat.txt")    
#a1=reading_file("a1q1.mutations.combined155123.csv")
writing_file("deleted_silent.txt",a1)
#writing_file("deleted_silent.csv",a1)
#print(a1[1].split(","))
