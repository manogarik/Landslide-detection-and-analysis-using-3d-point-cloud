import h5py
import scipy.io as sio
import numpy as np
filepath = 'dod.mat'
arrays = {}

def main():
    
    landslide_profile=sio.loadmat('landslide_profile.mat')
    area=0;
    roughness=sio.loadmat('roughness.mat')
    for i in range(0,len(landslide_profile["landslide_profile"])):
        for j in range(0,len(landslide_profile["landslide_profile"][i])):
            if landslide_profile["landslide_profile"][i][j]>0:
                if roughness["roughness"][i][j]>3:
                    area=area+1;
    
    area=area/(2*14.63);
    print('Landslide affected area is',round(area*134,2),'m2')
    
    return area
   


if __name__ == "__main__":
    main()
