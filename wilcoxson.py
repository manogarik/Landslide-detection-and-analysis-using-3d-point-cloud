import h5py
import scipy.io as sio
import numpy as np
from scipy.stats import rankdata

def main():
    
    dod=sio.loadmat('dod.mat')
    (rows,cols)=np.shape(dod["dod"])
    median=sio.loadmat('median.mat')
    (rows2,cols2)=np.shape(median["vert_median"])
    landslide_profile=np.zeros((rows,cols))
    med=median["vert_median"][rows2-1,cols2-1]
    print(med)
    dod["dod"]=dod["dod"]-med
    for r in range(1,rows-1):
        for c in range(1,cols-1):
            temp_win=dod["dod"][r-1:r+2,c-1:c+2]
            
            abs_dif=np.zeros((3,3))
            for i in range(0,2):
                for j in range(0,2):
                    if temp_win[i,j]<0:
                        abs_dif[i,j]=(-1)*temp_win[i,j]
                    else:
                        abs_dif[i,j]=temp_win[i,j]
            
            ranks=rankdata(abs_dif).reshape(abs_dif.shape)
            
            Wminus=0
            Wplus=0
            for i in range(0,2):
                for j in range(0,2):
                    if temp_win[i,j]<0:
                        Wminus=Wminus+ranks[i,j]
                        ranks[i,j]=ranks[i,j]*(-1)
                    else:
                        Wplus=Wplus+ranks[i,j]
            if Wplus>15:
                landslide_profile[r-1:r+2,c-1:c+2]=1
                

                    
    sio.savemat('landslide_profile.mat', mdict={'landslide_profile': landslide_profile})
            
                       
    return



if __name__ == "__main__":
    main()