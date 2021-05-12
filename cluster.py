import h5py
import scipy.io as sio
import numpy as np
from sklearn import cluster

def main():
    landslide_profile=sio.loadmat('landslide_profile.mat')
    hillshade=sio.loadmat('hillshade.mat')
    curv=sio.loadmat('prof_curv.mat')
    rough=sio.loadmat('roughness.mat')
    slope=sio.loadmat('slope.mat')
    (rows,cols)=np.shape(slope["slope"])
    data=np.zeros((rows*cols,4))
    j=0
    k=0
    for i in range(0,(rows*cols)-1):
        data[i,0]=rough["roughness"][j][k]
        
        data[i,1]=hillshade["hillshade"][j][k]
        data[i,2]=curv["prof_curv"][j][k]
        data[i,3]=slope["slope"][j][k]
        k=k+1
        if k>=cols:
            j=j+1
            k=0
    X = rough["roughness"].reshape((-1, 1))
    k_means = cluster.KMeans(n_clusters=4)
    _ = k_means.fit(X)
    X_clustered = k_means.labels_
    X_clustered = X_clustered.reshape(rough["roughness"].shape)
    Y = slope["slope"].reshape((-1, 1))
    k_means = cluster.KMeans(n_clusters=4)
    _ = k_means.fit(Y)
    Y_clustered = k_means.labels_
    Y_clustered = Y_clustered.reshape(slope["slope"].shape)

    Z = curv["prof_curv"].reshape((-1, 1))
    k_means = cluster.KMeans(n_clusters=4)
    _ = k_means.fit(Z)
    Z_clustered = k_means.labels_
    Z_clustered = Z_clustered.reshape(curv["prof_curv"].shape)
    
    
    
    return

if __name__ == "__main__":
    main()
    

    