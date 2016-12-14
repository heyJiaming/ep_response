//
//  AM_RESPONSE.m
//  ep-response
//
//  Created by 乐野 on 2016/12/9.
//  Copyright © 2016年 乐野. All rights reserved.
//

#import "AM_RESPONSE.h"
#import "math.h"
#import "stdio.h"

#define PI 3.1415926



@implementation AM_RESPONSE

+ (void) ep_amsponse_ofB: (NSArray<NSNumber *> *) b andA: (NSArray<NSNumber *> *) a order: (int) order am_result: (NSMutableArray<NSNumber *> *) am_reuslt length: (int) len
{
    const int fft_len = len * 2;
    const int n = fft_len * 2;
    int i, j;
    
    vDSP_DFT_SetupD setup = vDSP_DFT_zrop_CreateSetupD(NULL, n, vDSP_DFT_FORWARD);
    
    double b_in[fft_len];
    double a_in[fft_len];
    double i_in[fft_len];
    double b_out_r[fft_len];
    double b_out_i[fft_len];
    double a_out_r[fft_len];
    double a_out_i[fft_len];
    
    memset(a_in, 0, sizeof(double) * fft_len);
    memset(b_in, 0, sizeof(double) * fft_len);
    memset(i_in, 0, sizeof(double) * fft_len);
    
    for(i = 0; i < order; i++) {
        j = i % fft_len;
        a_in[j] += a[i].doubleValue;
        b_in[j] += b[i].doubleValue;
    }
    
    vDSP_DFT_ExecuteD(setup, a_in, i_in, a_out_r, a_out_i);
    vDSP_DFT_ExecuteD(setup, b_in, i_in, b_out_r, b_out_i);
    vDSP_DFT_DestroySetupD(setup);
    
    // unpack the result
    a_out_i[0] = 0;
    b_out_i[0] = 0;
    
    for(i = 0; i < len; i++) {
        [am_reuslt addObject:@(10 * log10((b_out_r[i] * b_out_r[i] + b_out_i[i] * b_out_i[i])/(a_out_r[i] * a_out_r[i] + a_out_i[i] * a_out_i[i])))];
    }
    
    
    
    return;
}

+ (void) test_ep_amsponse_ofB: (NSArray<NSNumber *> *) b andA: (NSArray<NSNumber *> *) a order: (int) order am_result: (NSMutableArray<NSNumber *> *) am_reuslt length: (int) len
{
    const int fft_len = len * 2;
    const int n = fft_len * 2;
    int i, j;
    
    vDSP_DFT_SetupD setup = vDSP_DFT_zrop_CreateSetupD(NULL, n, vDSP_DFT_FORWARD);
    
    double b_in[fft_len];
    double a_in[fft_len];
    double i_in[fft_len];
    double b_out_r[fft_len];
    double b_out_i[fft_len];
    double a_out_r[fft_len];
    double a_out_i[fft_len];
    
    memset(a_in, 0, sizeof(double) * fft_len);
    memset(b_in, 0, sizeof(double) * fft_len);
    memset(i_in, 0, sizeof(double) * fft_len);
    
    for(i = 0; i < order; i++) {
        j = i % fft_len;
        a_in[j] += a[order - i - 1].doubleValue;
        b_in[j] += b[order - i - 1].doubleValue;
    }

    printf("\n");
    
    vDSP_DFT_ExecuteD(setup, a_in, i_in, a_out_r, a_out_i);
    vDSP_DFT_ExecuteD(setup, b_in, i_in, b_out_r, b_out_i);
    vDSP_DFT_DestroySetupD(setup);
    
    // unpack the result
    a_out_i[0] = 0;
    b_out_i[0] = 0;
    
    for(i = 0; i < len; i++) {
        [am_reuslt addObject:@(sqrt((b_out_r[i] * b_out_r[i] + b_out_i[i] * b_out_i[i])/(a_out_r[i] * a_out_r[i] + a_out_i[i] * a_out_i[i])))];
        
    }
    
    return;
}

+ (void) test_dft {
    const int log2n = 4;
    const int n = 1 << log2n;
    const int nOver2 = n / 2;
    
    vDSP_DFT_SetupD setup = vDSP_DFT_zrop_CreateSetupD(NULL, n, vDSP_DFT_FORWARD);
    
    double Ir[8] = {1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0};
    double Ii[8] = {0, 0, 0, 0, 0, 0, 0, 0};
    double Or[8];
    double Oi[8];
    
    vDSP_DFT_ExecuteD(setup, Ir, Ii, Or, Oi);
    vDSP_DFT_DestroySetupD(setup);
    
    printf("DFT output\n");
    
    for (int i = 0; i < nOver2; ++i)
    {
        printf("%d: %8g%8g\n", i, Or[i], Oi[i]);
    }
    return;
}

// code from Paul R
+ (void) test_fft {
    const int log2n = 4;
    const int n = 1 << log2n;
    const int nOver2 = n / 2;
    
    FFTSetupD fftSetup = vDSP_create_fftsetupD (log2n, kFFTRadix2);
    
    double *input;
    
    DSPDoubleSplitComplex fft_data;
    
    int i;
    
    input = malloc(n * sizeof(double));
    fft_data.realp = malloc(nOver2 * sizeof(double));
    fft_data.imagp = malloc(nOver2 * sizeof(double));
    
    for (i = 0; i < nOver2; ++i)
    {
        input[2 * i] = (double)(i + 1);
        input[2 * i + 1] = 0;
    }
    
    printf("Input\n");
    
    for (i = 0; i < n; ++i)
    {
        printf("%d: %8g\n", i, input[i]);
    }
    
    vDSP_ctozD((DSPDoubleComplex *)input, 2, &fft_data, 1, nOver2);
    
    printf("FFT Input\n");
    
    for (i = 0; i < nOver2; ++i)
    {
        printf("%d: %8g%8g\n", i, fft_data.realp[i], fft_data.imagp[i]);
    }
    
    vDSP_fft_zripD (fftSetup, &fft_data, 1, log2n, kFFTDirection_Forward);
    
    printf("FFT output\n");
    
    for (i = 0; i < nOver2; ++i)
    {
        printf("%d: %8g%8g\n", i, fft_data.realp[i], fft_data.imagp[i]);
    }
    
    for (i = 0; i < nOver2; ++i)
    {
        fft_data.realp[i] *= 0.5;
        fft_data.imagp[i] *= 0.5;
    }
    
    printf("Scaled FFT output\n");
    
    for (i = 0; i < nOver2; ++i)
    {
        printf("%d: %8g%8g\n", i, fft_data.realp[i], fft_data.imagp[i]);
    }
    
    printf("Unpacked output\n");
    
    printf("%d: %8g%8g\n", 0, fft_data.realp[0], 0.0); // DC
    for (i = 1; i < nOver2; ++i)
    {
        printf("%d: %8g%8g\n", i, fft_data.realp[i], fft_data.imagp[i]);
    }
    printf("%d: %8g%8g\n", nOver2, fft_data.imagp[0], 0.0); // Nyquist
    
    return;
}

@end




