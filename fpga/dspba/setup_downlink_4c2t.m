 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %  
 % Copyright (c) 2017, BigCat Wireless Pvt Ltd
 % All rights reserved.
 % 
 % Redistribution and use in source and binary forms, with or without
 % modification, are permitted provided that the following conditions are met:
 % 
 %     * Redistributions of source code must retain the above copyright notice,
 %       this list of conditions and the following disclaimer.
 %
 %     * Redistributions in binary form must reproduce the above copyright
 %       notice, this list of conditions and the following disclaimer in the
 %       documentation and/or other materials provided with the distribution.
 %
 %     * Neither the name of the copyright holder nor the names of its contributors
 %       may be used to endorse or promote products derived from this software
 %       without specific prior written permission.
 % 
 % 
 % 
 % THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 % AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 % IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 % DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 % FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 % DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 % SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 % CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 % OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 % OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 % 
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% DUC_LINEUP_param - DSPBA Design Parameters Start
clear DUC_LINEUP_param; 

%%%%%%%%%%% Specify whether to generate Co-efficients or use(load) already existing co-efficient


coeff='load'; config='downlink_4c2t_coeff_cfg_08'; 
%%%%coeff='generate';

chanfilt_coeff = [ config '/chanfilt_coeffs.txt'];
hb4_coeff      = [ config '/hbint04_coeffs.txt'];
hb5_coeff      = [ config '/hbint05_coeffs.txt'];
hb6_coeff      = [ config '/hbint06_coeffs.txt'];
hb7_coeff      = [ config '/hbint07_coeffs.txt'];

DSPBA_Features.EnableFanoutBlocks = true;

DSPBA_Features.pipelineAdderUsingWidth = 20;

%DSPBA_Features.maxDSPBlockChainLength = 33;

format long;  
OccupiedBW = 0.9; % Proportion of LTE carrier filled with subcarriers


%% System Parameters
DUC_LINEUP_param.ChanCount        = 2;               % How many data channels
DUC_LINEUP_param.ClockRate        = 491.52;          % The system clock rate in MHz
DUC_LINEUP_param.SampleRate_5MHz  = 7.68;            % The data rate per channel in MSps (mega-samples per second)
DUC_LINEUP_param.SampleRate_10MHz = 15.36;           % The data rate per channel in MSps (mega-samples per second)
DUC_LINEUP_param.SampleRate_20MHz = 30.72; 
DUC_LINEUP_param.Base_addr        = 0;

DUC_LINEUP_param.ClockMargin      = 127;             % Adjust the pipelining effort
DUC_LINEUP_param.ClockMargin_DPD  = 127;
DUC_LINEUP_param.ClockMargin_CFR  = 50;
DUC_LINEUP_param.ClockMargin_DUC  = 127;

%%%%%%%%%%%%%%%%%%%%% BASE AND SIGNAL FREQ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

DUC_LINEUP_param.A1xC1_Freq = -8;                  
DUC_LINEUP_param.A1xC2_Freq = -7;                  
DUC_LINEUP_param.A1xC3_Freq = -6;                  
DUC_LINEUP_param.A1xC4_Freq = -5; 

DUC_LINEUP_param.A2xC1_Freq = 5;                  
DUC_LINEUP_param.A2xC2_Freq = 6;                  
DUC_LINEUP_param.A2xC3_Freq = 7;                  
DUC_LINEUP_param.A2xC4_Freq = 8; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% NCO Tunning Frequncy selection %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

DUC_LINEUP_param.A12xC_NCO.Freq                   = [0 0 0 0 0 0 0 0];

Blind_CFR1_ClipValue = 0.15; 
Blind_CFR2_ClipValue = 0.15; 
Blind_CFR1_Enalbe = 1;
Blind_CFR2_Enalbe = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Number of channel selection %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

DUC_LINEUP_param.SampleRate_A1xC1=DUC_LINEUP_param.SampleRate_20MHz;
DUC_LINEUP_param.SampleRate_A1xC2=DUC_LINEUP_param.SampleRate_20MHz;
DUC_LINEUP_param.SampleRate_A1xC3=DUC_LINEUP_param.SampleRate_20MHz;
DUC_LINEUP_param.SampleRate_A1xC4=DUC_LINEUP_param.SampleRate_20MHz;

DUC_LINEUP_param.SampleRate_A2xC1=DUC_LINEUP_param.SampleRate_20MHz;
DUC_LINEUP_param.SampleRate_A2xC2=DUC_LINEUP_param.SampleRate_20MHz;
DUC_LINEUP_param.SampleRate_A2xC3=DUC_LINEUP_param.SampleRate_20MHz;
DUC_LINEUP_param.SampleRate_A2xC4=DUC_LINEUP_param.SampleRate_20MHz;


%% Data Type Specification
DUC_LINEUP_param.input_word_length      = 16;         % Input data: bit width
DUC_LINEUP_param.input_fraction_length  = 15;         % Input data: fraction width

DUC_LINEUP_param.output_word_length     = 16;         % Output data: bit width
DUC_LINEUP_param.output_fraction_length = 15;         % Output data: fraction width



%% ModelIP setup


%% Filter 1- channal filter
DUC_LINEUP_param.chan_filter.SampleRate            = DUC_LINEUP_param.SampleRate_20MHz;         % Input rate at filter1
DUC_LINEUP_param.chan_filter.FilterLength          = 87;                                        % Number of Taps is not doesnt depend on parameter- Filter Lengh. It inherits from Coefficient file.
DUC_LINEUP_param.chan_filter.coeff_word_length     = 16;                                        % filter1 coefficient: bit width
DUC_LINEUP_param.chan_filter.coeff_fraction_length = 15;                         
DUC_LINEUP_param.chan_filter.base_addr1             = DUC_LINEUP_param.Base_addr + 128;                       
%%DUC_LINEUP_param.chan_filter.base_addr2             = DUC_LINEUP_param.chan_filter.base_addr1+256;        
DUC_LINEUP_param.chan_filter.ChanCount              = DUC_LINEUP_param.ChanCount*8;


%% Filter 4 -  HB2 Filer4

DUC_LINEUP_param.HB_filt4.SampleRate            = DUC_LINEUP_param.SampleRate_20MHz;         % Input rate at filter4  - 30.72-- 4*7.68
DUC_LINEUP_param.HB_filt4.FilterLength          = 47;                          % Number of Taps is not doesnt depend on parameter- Filter Lengh. It inherits from Coefficient file.
DUC_LINEUP_param.HB_filt4.Interpolation         = 2;                           % Interpolation rate  
DUC_LINEUP_param.HB_filt4.coeff_word_length     = 16;                          % filter4 coefficient: bit width
DUC_LINEUP_param.HB_filt4.coeff_fraction_length = 15;                          % filter4 coefficient: fraction width 
DUC_LINEUP_param.HB_filt4.base_addr1             =  DUC_LINEUP_param.chan_filter.base_addr1 + 128;
%%DUC_LINEUP_param.HB_filt4.base_addr2             =  DUC_LINEUP_param.HB_filt4.base_addr1 + 256;
DUC_LINEUP_param.HB_filt4.ChanCount               = DUC_LINEUP_param.ChanCount*8;


%% Filter 5 -  HB2 Filer5

DUC_LINEUP_param.HB_filt5.SampleRate            = DUC_LINEUP_param.SampleRate_20MHz*2;         % Input rate at filter5  - -61.44- 2*30.72
DUC_LINEUP_param.HB_filt5.FilterLength          = 27;                          % Number of Taps is not doesnt depend on parameter- Filter Lengh. It inherits from Coefficient file.
DUC_LINEUP_param.HB_filt5.Interpolation         = 2;                           % Interpolation rate  
DUC_LINEUP_param.HB_filt5.coeff_word_length     = 16;                          % filter5 coefficient: bit width
DUC_LINEUP_param.HB_filt5.coeff_fraction_length = 15;                          % filter5 coefficient: fraction width 
DUC_LINEUP_param.HB_filt5.base_addr1             =  DUC_LINEUP_param.HB_filt4.base_addr1 + 128;
DUC_LINEUP_param.HB_filt5.ChanCount              = DUC_LINEUP_param.ChanCount*4;

DUC_LINEUP_param.HB_filt5_2.base_addr1             =  DUC_LINEUP_param.HB_filt5.base_addr1 + 128;
DUC_LINEUP_param.HB_filt5_2.ChanCount              = DUC_LINEUP_param.ChanCount*4;

%% carrier NCO Ant 12
DUC_LINEUP_param.NCO.SampleRate            = DUC_LINEUP_param.SampleRate_20MHz*4;                        % output rate at NCO  - 122.88 -- 4*30.72
DUC_LINEUP_param.NCO.Data_type             = DUC_LINEUP_param.output_word_length;
DUC_LINEUP_param.NCO.scaling_value         = DUC_LINEUP_param.output_fraction_length;
DUC_LINEUP_param.NCO.Acumulater_bit_wid    = 24;                          
DUC_LINEUP_param.A12xC_NCO.Freq_word       = ((DUC_LINEUP_param.A12xC_NCO.Freq*2^DUC_LINEUP_param.NCO.Acumulater_bit_wid) / (DUC_LINEUP_param.NCO.SampleRate)) ;                          % Interpolation rate  
DUC_LINEUP_param.A12xC_NCO.base_addr       = DUC_LINEUP_param.HB_filt5_2.base_addr1 + 128;
DUC_LINEUP_param.A12xC_NCO.Sync            = DUC_LINEUP_param.A12xC_NCO.base_addr + 128;


%% complex mixer
DUC_LINEUP_param.CM.SampleRate            = DUC_LINEUP_param.SampleRate_20MHz*4;                              % output rate at CM  - 122.88 -- 4*30.72
DUC_LINEUP_param.CM.No_Of_Complex_chan    = 8;
DUC_LINEUP_param.CM.No_Of_Complex_Freq    = 8;

%% Filter 6 -  HB2 Filer6

DUC_LINEUP_param.HB_filt6.SampleRate            = DUC_LINEUP_param.SampleRate_20MHz*4;         % Input rate at filter5  -122.88 -4*30.72
DUC_LINEUP_param.HB_filt6.FilterLength          = 17;                          % Number of Taps is not doesnt depend on parameter- Filter Lengh. It inherits from Coefficient file.
DUC_LINEUP_param.HB_filt6.Interpolation         = 2;                           % Interpolation rate  
DUC_LINEUP_param.HB_filt6.coeff_word_length     = 16;                          % filter5 coefficient: bit width
DUC_LINEUP_param.HB_filt6.coeff_fraction_length = 15;                          % filter5 coefficient: fraction width 
DUC_LINEUP_param.HB_filt6.base_addr1            = DUC_LINEUP_param.A12xC_NCO.Sync + 16;
%%DUC_LINEUP_param.HB_filt6.base_addr2            = DUC_LINEUP_param.HB_filt6.base_addr1 + 256;
DUC_LINEUP_param.HB_filt6.ChanCount             = DUC_LINEUP_param.ChanCount*2;


%% Filter 7 -  HB2 Filer7
DUC_LINEUP_param.HB_filt7.SampleRate            = DUC_LINEUP_param.SampleRate_20MHz*8;         % Input rate at filter5  -245.76 -8*30.72
DUC_LINEUP_param.HB_filt7.FilterLength          = 15;                          % Number of Taps is not doesnt depend on parameter- Filter Lengh. It inherits from Coefficient file.
DUC_LINEUP_param.HB_filt7.Interpolation         = 2;                           % Interpolation rate  
DUC_LINEUP_param.HB_filt7.coeff_word_length     = 16;                          % filter5 coefficient: bit width
DUC_LINEUP_param.HB_filt7.coeff_fraction_length = 15;                          % filter5 coefficient: fraction width 
DUC_LINEUP_param.HB_filt7.base_addr1            = DUC_LINEUP_param.HB_filt6.base_addr1 + 128;
%%DUC_LINEUP_param.HB_filt7.base_addr2            = DUC_LINEUP_param.HB_filt7.base_addr1 + 256;
DUC_LINEUP_param.HB_filt7.ChanCount             = DUC_LINEUP_param.ChanCount*2;


  

% if(strcmp(coeff,'load')==1) 
      
    DUC_LINEUP_param.chan_filter.coeffs(1,:)  =fi(load(chanfilt_coeff),1,DUC_LINEUP_param.chan_filter.coeff_word_length,DUC_LINEUP_param.chan_filter.coeff_fraction_length);
    DUC_LINEUP_param.HB_filt4.coeffs(1,:)     =fi(load(hb4_coeff),1,DUC_LINEUP_param.HB_filt4.coeff_word_length,DUC_LINEUP_param.HB_filt4.coeff_fraction_length);
    DUC_LINEUP_param.HB_filt5.coeffs(1,:)     =fi(load(hb5_coeff),1,DUC_LINEUP_param.HB_filt5.coeff_word_length,DUC_LINEUP_param.HB_filt5.coeff_fraction_length);
    DUC_LINEUP_param.HB_filt6.coeffs(1,:)     =fi(load(hb6_coeff),1,DUC_LINEUP_param.HB_filt6.coeff_word_length,DUC_LINEUP_param.HB_filt6.coeff_fraction_length);
    DUC_LINEUP_param.HB_filt7.coeffs(1,:)     =fi(load(hb7_coeff),1,DUC_LINEUP_param.HB_filt7.coeff_word_length,DUC_LINEUP_param.HB_filt7.coeff_fraction_length);

% end


%% Simulation Parameters
DUC_LINEUP_param.SampleTime  = 1;                    % One unit in Simulink simulation is one clock cycle 
DUC_LINEUP_param.endTime     = 50000;                 % How many simulation clock cycles
DUC_LINEUP_param.ContiguousValidFrames   = 1;        % Create a sequence of valid and invali frames of stimulus data in the Channelizer block
DUC_LINEUP_param.ContiguousInvalidFrames = 1; 





%********************************** LTE TEST *********************************************

carr1_file_data_vec=load('downlink_4c2t_tc06_lte20_30p72_0.mat');
carr1_file_data=carr1_file_data_vec.Hepta_Test_Vector_Data;
gain=1;
carr1_file_data=carr1_file_data*gain;
real_data1 = carr1_file_data(1:2:end);
imag_data1 = carr1_file_data(2:2:end);
fvtool(complex(real_data1,imag_data1),'fs',30.72e6);

carr2_file_data_vec=load('downlink_4c2t_tc02_singletone20_30p72_0.mat');
carr2_file_data=carr2_file_data_vec.Hepta_Test_Vector_Data;
gain=1;
carr2_file_data=carr2_file_data*gain;
real_data2 = carr2_file_data(1:2:end);
imag_data2 = carr2_file_data(2:2:end);
fvtool(complex(real_data2,imag_data2),'fs',30.72e6);

carr3_file_data_vec=load('downlink_4c2t_tc03_singletone20_30p72_0.mat');
carr3_file_data=carr3_file_data_vec.Hepta_Test_Vector_Data;
gain=1;
carr3_file_data=carr3_file_data*gain;
real_data3 = carr3_file_data(1:2:end);
imag_data3 = carr3_file_data(2:2:end);
fvtool(complex(real_data3,imag_data3),'fs',30.72e6);

carr4_file_data_vec=load('downlink_4c2t_tc04_singletone20_30p72_0.mat');
carr4_file_data=carr4_file_data_vec.Hepta_Test_Vector_Data;
gain=1;
carr4_file_data=carr4_file_data*gain;
real_data4 = carr4_file_data(1:2:end);
imag_data4 = carr4_file_data(2:2:end);
fvtool(complex(real_data4,imag_data4),'fs',30.72e6);

%%********************************** Signal Initialization *********************************************

zero_data = zeros(1,length(carr1_file_data)/2);

DUC_LINEUP_param.inputdata_A1xC1(1,:) = zero_data;
DUC_LINEUP_param.inputdata_A1xC1(2,:) = zero_data;
DUC_LINEUP_param.inputdata_A1xC2(1,:) = zero_data;
DUC_LINEUP_param.inputdata_A1xC2(2,:) = zero_data;
DUC_LINEUP_param.inputdata_A1xC3(1,:) = zero_data;
DUC_LINEUP_param.inputdata_A1xC3(2,:) = zero_data;
DUC_LINEUP_param.inputdata_A1xC4(1,:) = zero_data;
DUC_LINEUP_param.inputdata_A1xC4(2,:) = zero_data;

DUC_LINEUP_param.inputdata_A2xC1(1,:) = zero_data;
DUC_LINEUP_param.inputdata_A2xC1(2,:) = zero_data;
DUC_LINEUP_param.inputdata_A2xC2(1,:) = zero_data;
DUC_LINEUP_param.inputdata_A2xC2(2,:) = zero_data;
DUC_LINEUP_param.inputdata_A2xC3(1,:) = zero_data;
DUC_LINEUP_param.inputdata_A2xC3(2,:) = zero_data;
DUC_LINEUP_param.inputdata_A2xC4(1,:) = zero_data;
DUC_LINEUP_param.inputdata_A2xC4(2,:) = zero_data;

%%********************************** Signal Assignment *********************************************

DUC_LINEUP_param.inputdata_A1xC1(1,:) = real_data1;
DUC_LINEUP_param.inputdata_A1xC1(2,:) = imag_data1;
DUC_LINEUP_param.inputdata_A1xC2(1,:) = real_data1;
DUC_LINEUP_param.inputdata_A1xC2(2,:) = imag_data1;
DUC_LINEUP_param.inputdata_A1xC3(1,:) = real_data1;
DUC_LINEUP_param.inputdata_A1xC3(2,:) = imag_data1;
DUC_LINEUP_param.inputdata_A1xC4(1,:) = real_data1;
DUC_LINEUP_param.inputdata_A1xC4(2,:) = imag_data1;


DUC_LINEUP_param.inputdata_A2xC1(1,:) = real_data2;
DUC_LINEUP_param.inputdata_A2xC1(2,:) = imag_data2;
DUC_LINEUP_param.inputdata_A2xC2(1,:) = real_data2;
DUC_LINEUP_param.inputdata_A2xC2(2,:) = imag_data2;
DUC_LINEUP_param.inputdata_A2xC3(1,:) = real_data2;
DUC_LINEUP_param.inputdata_A2xC3(2,:) = imag_data2;
DUC_LINEUP_param.inputdata_A2xC4(1,:) = real_data2;
DUC_LINEUP_param.inputdata_A2xC4(2,:) = imag_data2;


%% Derived Parameters 
DUC_LINEUP_param.Period_A1xC1          = ceil(DUC_LINEUP_param.ClockRate / DUC_LINEUP_param.SampleRate_A1xC1);           % Clock cycles between consecutive data samples for a particular channel
DUC_LINEUP_param.Period_A1xC2          = ceil(DUC_LINEUP_param.ClockRate / DUC_LINEUP_param.SampleRate_A1xC2);           % Clock cycles between consecutive data samples for a particular channel
DUC_LINEUP_param.Period_A1xC3          = ceil(DUC_LINEUP_param.ClockRate / DUC_LINEUP_param.SampleRate_A1xC3);           % Clock cycles between consecutive data samples for a particular channel
DUC_LINEUP_param.Period_A1xC4          = ceil(DUC_LINEUP_param.ClockRate / DUC_LINEUP_param.SampleRate_A1xC4);           % Clock cycles between consecutive data samples for a particular channel


DUC_LINEUP_param.Period_A2xC1          = ceil(DUC_LINEUP_param.ClockRate / DUC_LINEUP_param.SampleRate_A2xC1);           % Clock cycles between consecutive data samples for a particular channel
DUC_LINEUP_param.Period_A2xC2          = ceil(DUC_LINEUP_param.ClockRate / DUC_LINEUP_param.SampleRate_A2xC2);           % Clock cycles between consecutive data samples for a particular channel
DUC_LINEUP_param.Period_A2xC3          = ceil(DUC_LINEUP_param.ClockRate / DUC_LINEUP_param.SampleRate_A2xC3);           % Clock cycles between consecutive data samples for a particular channel
DUC_LINEUP_param.Period_A2xC4          = ceil(DUC_LINEUP_param.ClockRate / DUC_LINEUP_param.SampleRate_A2xC4);           % Clock cycles between consecutive data samples for a particular channel





%%%%%%%%%%%%%%%%% Configuration 0 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clock_rate  = 491.52;
sample_rate = 491.52;

% Generating Channel/valid signals:
% cSig = [0 1];
% vSig = 1;

in_band = [-38e6 -22e6; -18e6 -2e6; 2e6 18e6; 22e6 38e6]; 

% dut id unique identifier
% register's addresses
REG_dut_id_addr = 0;

cfr_cordic_gain = 1.8;
cfr_stages = 8;
cfr_xy_cord_bits = 18;
cfr_xy_cord_fractional_bits = 14;
cfr_angle_cord_bits = 16;
cfr_angle_cord_fractional_bits = 15;


% Individual Iteration Registers Offset
% The individual register address thus becomes
% REG_Iter_<n>_Base_Addr + REG_<name>
REG.Threshold  = 128;
REG.Scaling    = 132;
REG.Enable     = 136;
REG.pulseLen   = 137;
REG.winLen     = 138;
REG.LoadCnt    = 139;

cfr0_id = 8;

PulsExtention = 128;



% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Iteration 0 Configurations
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Iter0_Param.BaseAddr      = DUC_LINEUP_param.HB_filt7.base_addr1+256;                    % processor interface start address
Iter0_Param.ClipVal       = Blind_CFR1_ClipValue * cfr_cordic_gain; % initial clipping amplitude (re-programmable during run-time)
Iter0_Param.Scaling       = 1.0;                     % initial Power Scaling value, between 0.0 to 1.99
Iter0_Param.Enable        = Blind_CFR1_Enalbe;
Iter0_Param.pulseLen      = 64;
Iter0_Param.winLen        = Iter0_Param.pulseLen + 2*PulsExtention;
Iter0_Param.LoadCnt       = 0;
cfr_Params0               = Iter0_Param;

%w = transpose( kaiser(2*PulsExtention,8) );        
w = transpose( hanning(2*PulsExtention,'symmetric') );
win_enable = 1;
win = [w(1:PulsExtention) ones(1,Iter0_Param.pulseLen) w(PulsExtention+1:end)];

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Iteration 1 Configurations
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Iter1_Param.BaseAddr      = Iter0_Param.BaseAddr + 3200;                    % processor interface start address
Iter1_Param.ClipVal       = Blind_CFR2_ClipValue * cfr_cordic_gain; % initial clipping amplitude (re-programmable during run-time)
Iter1_Param.Scaling       = 1.0;                     % initial Power Scaling value, between 0.0 to 1.99
Iter1_Param.Enable        = Blind_CFR2_Enalbe;
Iter1_Param.pulseLen      = 64;
Iter1_Param.winLen        = Iter1_Param.pulseLen + 2*PulsExtention;
Iter1_Param.LoadCnt       = 0;
cfr_Params1               = Iter1_Param;

% %%%%%%%%%%%%%%%%%% DPD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Clock rate and sample rate.  
if exist('OverrideClockRate', 'var')
    clock_rate_dpd = OverrideClockRate;
else
    clock_rate_dpd = 491.52;
    
end


 load('downlink_4c2t_luts.mat')
 load('downlink_4c2t_dpd_clip.mat')

sample_rate_dpd = clock_rate_dpd;

%%
cordic_gain = 1.8;%%1.646760257865452963193594414453; %% 1.8 
WordLength = 16;
FractionLength = 15;
OutputScalingFactor = 2^-FractionLength;
LUT_OutputScalingFactor = 2^-(FractionLength - 5);

dpd_stages = 10; %ceil(log2(size(LutContent,1))+2);
dpd_xy_angle_bits = 16;
dpd_xy_angle_fract_bits = 15;
dpd_xy_bits = 18;
dpd_xy_fract_bits = 14;


%%

% To enable DPD - '1' 
enable_DPD1 = 1;
enable_DPD2 = 1;

fxp_coeff_width = 16;

% dut id unique identifier
predistort0_id = 6;

% Initial filter coefficients.
% coef1=fir1(8,.4) + 1i * fir1(8,.7);
% coef2=fir1(8,.5) + 1i * fir1(8,.3);
% coef3=fir1(8,.6) + 1i * fir1(8,.2);

% av-mm  memory address.

StartAddress1= Iter1_Param.BaseAddr + 3200;
StartAddress2= StartAddress1+1024 ;




%%%%%%%%%%%%%%%%%% GAIN %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


ant1_carr1_gain_addr = StartAddress2 + 1024;
ant1_carr2_gain_addr = ant1_carr1_gain_addr + 1;
ant1_carr3_gain_addr = ant1_carr2_gain_addr + 1;
ant1_carr4_gain_addr = ant1_carr3_gain_addr + 1;

ant2_carr1_gain_addr = ant1_carr4_gain_addr + 1;
ant2_carr2_gain_addr = ant2_carr1_gain_addr + 1;
ant2_carr3_gain_addr = ant2_carr2_gain_addr + 1;
ant2_carr4_gain_addr = ant2_carr3_gain_addr + 1;

ant1_summer_gain_addr = ant2_carr4_gain_addr + 1;
ant2_summer_gain_addr = ant1_summer_gain_addr + 1;

dpd1_gain_addr = ant2_summer_gain_addr +1;
dpd2_gain_addr = dpd1_gain_addr + 1;

ant1_carr1_gain_val_init = 1;
ant1_carr2_gain_val_init = 1;
ant1_carr3_gain_val_init = 1;
ant1_carr4_gain_val_init = 1;

ant2_carr1_gain_val_init = 1;
ant2_carr2_gain_val_init = 1;
ant2_carr3_gain_val_init = 1;
ant2_carr4_gain_val_init = 1;

ant1_summer_gain_init = 1;
ant2_summer_gain_init = 1;

dpd1_gain_init_value =1;
dpd2_gain_init_value =1;


%%%%%%%%%%%%%%%%%% SUMMER SHFITER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Sum_shifter_addr = dpd2_gain_addr+16;
Sum_shifter_init_value = 2;

%%%%%%%%%%%%%%%%%% POWER METER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


power_meter_param.carr1_pd_address              = Sum_shifter_addr+1;
power_meter_param.carr2_pd_address              = power_meter_param.carr1_pd_address+1;
power_meter_param.carr3_pd_address              = power_meter_param.carr2_pd_address+1;
power_meter_param.carr4_pd_address              = power_meter_param.carr3_pd_address+1;
power_meter_param.carr5_pd_address              = power_meter_param.carr4_pd_address+1;
power_meter_param.carr6_pd_address              = power_meter_param.carr5_pd_address+1;
power_meter_param.carr7_pd_address              = power_meter_param.carr6_pd_address+1;
power_meter_param.carr8_pd_address              = power_meter_param.carr7_pd_address+1;


power_meter_param.carr1_acc1_reg_addr          = power_meter_param.carr8_pd_address+1; 
power_meter_param.carr1_acc2_reg_addr          = power_meter_param.carr1_acc1_reg_addr +1;
power_meter_param.carr2_acc1_reg_addr          = power_meter_param.carr1_acc2_reg_addr +1;
power_meter_param.carr2_acc2_reg_addr          = power_meter_param.carr2_acc1_reg_addr +1;
power_meter_param.carr3_acc1_reg_addr          = power_meter_param.carr2_acc2_reg_addr +1;
power_meter_param.carr3_acc2_reg_addr          = power_meter_param.carr3_acc1_reg_addr +1;
power_meter_param.carr4_acc1_reg_addr          = power_meter_param.carr3_acc2_reg_addr +1;
power_meter_param.carr4_acc2_reg_addr          = power_meter_param.carr4_acc1_reg_addr +1;
power_meter_param.carr5_acc1_reg_addr          = power_meter_param.carr4_acc2_reg_addr +1;
power_meter_param.carr5_acc2_reg_addr          = power_meter_param.carr5_acc1_reg_addr +1;
power_meter_param.carr6_acc1_reg_addr          = power_meter_param.carr5_acc2_reg_addr +1;
power_meter_param.carr6_acc2_reg_addr          = power_meter_param.carr6_acc1_reg_addr +1;
power_meter_param.carr7_acc1_reg_addr          = power_meter_param.carr6_acc2_reg_addr +1;
power_meter_param.carr7_acc2_reg_addr          = power_meter_param.carr7_acc1_reg_addr +1;
power_meter_param.carr8_acc1_reg_addr          = power_meter_param.carr7_acc2_reg_addr +1;
power_meter_param.carr8_acc2_reg_addr          = power_meter_param.carr8_acc1_reg_addr +1;


power_meter_param.summer_ant1_pd_address      = power_meter_param.carr8_acc2_reg_addr+1;
power_meter_param.summer_ant2_pd_address      = power_meter_param.summer_ant1_pd_address+1;

power_meter_param.summer_ant1_acc1_reg_addr   = power_meter_param.summer_ant2_pd_address+1;
power_meter_param.summer_ant1_acc2_reg_addr   = power_meter_param.summer_ant1_acc1_reg_addr +1;
power_meter_param.summer_ant2_acc1_reg_addr   = power_meter_param.summer_ant1_acc2_reg_addr +1;
power_meter_param.summer_ant2_acc2_reg_addr   = power_meter_param.summer_ant2_acc1_reg_addr +1;

power_meter_param.dpd1_in_pd_address          = power_meter_param.summer_ant2_acc2_reg_addr+1;
power_meter_param.dpd2_in_pd_address          = power_meter_param.dpd1_in_pd_address+1;

power_meter_param.dpd1_in_acc1_reg_addr       = power_meter_param.dpd2_in_pd_address+1; 
power_meter_param.dpd1_in_acc2_reg_addr       = power_meter_param.dpd1_in_acc1_reg_addr+1;

power_meter_param.dpd2_in_acc1_reg_addr       = power_meter_param.dpd1_in_acc2_reg_addr+1;
power_meter_param.dpd2_in_acc2_reg_addr       = power_meter_param.dpd2_in_acc1_reg_addr+1;


power_meter_param.dpd1_out_pd_address        = power_meter_param.dpd2_in_acc2_reg_addr+1;
power_meter_param.dpd1_out_acc1_reg_addr     = power_meter_param.dpd1_out_pd_address +1;
power_meter_param.dpd1_out_acc2_reg_addr     = power_meter_param.dpd1_out_acc1_reg_addr+1;

power_meter_param.dpd2_out_pd_address        = power_meter_param.dpd1_out_acc2_reg_addr+1;
power_meter_param.dpd2_out_acc1_reg_addr     = power_meter_param.dpd2_out_pd_address+1;
power_meter_param.dpd2_out_acc2_reg_addr     = power_meter_param.dpd2_out_acc1_reg_addr+1;

Reg_busy_bit_addr = power_meter_param.dpd2_out_acc2_reg_addr +1 ;

%%%%%%%%%%%%%%%%%% DPD CLIPPER  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

DPD1_CLIP_DATA_Address = Reg_busy_bit_addr+1;

DPD1_CLIP_ADDR_Address = DPD1_CLIP_DATA_Address+1;

DPD2_CLIP_ADDR_Address = DPD1_CLIP_ADDR_Address+1;

DPD2_CLIP_DATA_Address=  DPD2_CLIP_ADDR_Address+1;

DPD1_CLIP_SCALE= DPD2_CLIP_DATA_Address+1;

DPD2_CLIP_SCALE= DPD1_CLIP_SCALE+1;

DPD1_CLIP_INIT_VALUE = 1;

DPD2_CLIP_INIT_VALUE = 1;
