import h5py
import scipy.io as sio
import numpy as np
filepath = 'dod.mat'
arrays = {}

def main():
    
    A=sio.loadmat('dod.mat')
    landslide_profile=sio.loadmat('landslide_profile.mat')
    
    
    volume=0;
    roughness=sio.loadmat('roughness.mat')
    for i in range(0,len(A["dod"])):
        for j in range(0,len(A["dod"][i])):
            if landslide_profile["landslide_profile"][i][j]>0:
                if roughness["roughness"][i][j]>3:
                    volume=volume+A["dod"][i][j];
    vol=volume;
    volume=volume/(14.63*2*14.63);
    print('Landslide affected volume is',round(volume,2),'m3')
    
    return vol
   


if __name__ == "__main__":
    main()
