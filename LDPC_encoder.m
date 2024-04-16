function LDPC_coded=LDPC_encoder(data,G)

    LDPC_coded=mod(data*G,2);

end