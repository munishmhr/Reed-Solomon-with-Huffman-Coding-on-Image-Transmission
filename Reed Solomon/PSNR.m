    orig = imread('self subsampled Gray Scale standard Quantization grade 1.jpg');
    compi = imread('Self Quantization 1.jpg');
    mse = (double(orig(:)) - double(compi(:))) .^ 2;    
    mse = sum(mse(:)) / (1024*1024);
    % Calculate PSNR (Peak Signal to noise ratio)
    psnr1 = 10 * log10( double(max(orig(:)))^2 / mse)
    
    
    
    
    
   compi = imread('Self Quantization 2.jpg');
    mse = (double(orig(:)) - double(compi(:))) .^ 2;    
    mse = sum(mse(:)) / (1024*1024);
    % Calculate PSNR (Peak Signal to noise ratio)
    psnr2 = 10 * log10( double(max(orig(:)))^2 / mse)
    
    
    
    compi = imread('Self Quantization 3.jpg');
    mse = (double(orig(:)) - double(compi(:))) .^ 2;    
    mse = sum(mse(:)) / (1024*1024);
    % Calculate PSNR (Peak Signal to noise ratio)
    psnr2 = 10 * log10( double(max(orig(:)))^2 / mse)
    