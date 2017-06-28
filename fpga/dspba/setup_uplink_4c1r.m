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
 %% DDC_Lineup_param - DSPBA Design Parameters Start
clear DDC_Lineup_param; 

%%%%%%%%%%% Specify whether to generate Co-efficients or use(load) already existing co-efficient

%coeff='generate';
coeff='load';
config='uplink_4c1r_coeff_cfg_04'; %%%%%%% if it is configuration 1 --> CFG-01 , configuration 2 --> CFG-02 , configuration 3 --> CFG-03 , configuration 4 --> CFG-04 , 


chanfilt_coeff = [ config '/ChanFilt_Coeffs.txt'];
hb4_coeff      = [ config '/HBdec04_Coeffs.txt'];
hb5_coeff      = [ config '/HBdec05_Coeffs.txt'];
hb6_coeff      = [ config '/HBdec06_Coeffs.txt'];
hb7_coeff      = [ config '/HBdec07_Coeffs.txt'];


DSPBA_Features.schedulerAttempts = 1000;

%% System Parameters
DDC_Lineup_param.ChanCount   = 1;                 % How many data channels
DDC_Lineup_param.ClockRate   = 491.52;            % The system clock rate in MHz
DDC_Lineup_param.SampleRate  = 491.52;            % The data rate per channel in MSps (mega-samples per second)

DDC_Lineup_param.ClockMargin = 100;  
DDC_Lineup_param.total_AxC   = 4 ;

% DDC_Lineup_param.Complex_NCO_A1.Freq = [-30 -10 10 30]; 

DDC_Lineup_param.Complex_NCO_A1.Freq = [0 0 0 0]; 
 
DDC_Lineup_param.Base_Addr   = 0 ;

format long;
OccupiedBW = 0.9; % Proportion of LTE carrier filled with subcarriers
           % The data rate per channel in MSps (mega-samples per second)


%% Data Type Specification
DDC_Lineup_param.input_word_length      = 16;         % Input data: bit width
DDC_Lineup_param.input_fraction_length  = 15;         % Input data: fraction width

DDC_Lineup_param.output_word_length     = 16;         % Output data: bit width
DDC_Lineup_param.output_fraction_length = 15;         % Output data: fraction width



%% ModelIP setup


DDC_Lineup_param.A1xC1_Freq = -35;      
DDC_Lineup_param.A1xC2_Freq = -8.5;
DDC_Lineup_param.A1xC3_Freq = 9.1;
DDC_Lineup_param.A1xC4_Freq = 32;


%%

DDC_Lineup_param.HB_filter7.SampleRate            = DDC_Lineup_param.SampleRate; % Input rate at filter1
DDC_Lineup_param.HB_filter7.Decimation            = 2;                           % Decimation rate  
DDC_Lineup_param.HB_filter7.ChanCount             = DDC_Lineup_param.ChanCount*2;
DDC_Lineup_param.HB_filter7.base_addr             = DDC_Lineup_param.Base_Addr+128;                         % filter1 coefficient address map (start)
DDC_Lineup_param.HB_filter7.coeff_word_length     = 16;                          % filter1 coefficient: bit width
DDC_Lineup_param.HB_filter7.coeff_fraction_length = 15;                          % filter1 coefficient: fraction width 
DDC_Lineup_param.HB_filter7.FilterLength          = 15; 


% Filter 1 - HB6
DDC_Lineup_param.HB_filter6.SampleRate            = DDC_Lineup_param.SampleRate/2; % Input rate at filter1
DDC_Lineup_param.HB_filter6.Decimation            = 2;                           % Decimation rate  
DDC_Lineup_param.HB_filter6.ChanCount             = DDC_Lineup_param.ChanCount*2;
DDC_Lineup_param.HB_filter6.base_addr1            = DDC_Lineup_param.HB_filter7.base_addr + 128;                         % filter1 coefficient address map (start)
DDC_Lineup_param.HB_filter6.coeff_word_length     = 16;                          % filter1 coefficient: bit width
DDC_Lineup_param.HB_filter6.coeff_fraction_length = 15;                          % filter1 coefficient: fraction width 
DDC_Lineup_param.HB_filter6.FilterLength          = 17; 



DDC_Lineup_param.Complex_NCO_A1.SampleRate            = DDC_Lineup_param.SampleRate/4;                       
DDC_Lineup_param.Complex_NCO_A1.Data_type             = DDC_Lineup_param.output_word_length;
DDC_Lineup_param.Complex_NCO_A1.scaling_value         = DDC_Lineup_param.output_fraction_length;
DDC_Lineup_param.Complex_NCO_A1.Acumulater_bit_wid    = 24;                          
DDC_Lineup_param.Complex_NCO_A1.Freq_word             = ((DDC_Lineup_param.Complex_NCO_A1.Freq*2^DDC_Lineup_param.Complex_NCO_A1.Acumulater_bit_wid) / (DDC_Lineup_param.Complex_NCO_A1.SampleRate)) ;                          
DDC_Lineup_param.Complex_NCO_A1.base_addr             = DDC_Lineup_param.HB_filter6.base_addr1 + 128;
DDC_LINEUP_param.NCO.Sync                             = DDC_Lineup_param.Complex_NCO_A1.base_addr + 128; 

%% complex mixer
DDC_Lineup_param.RM.SampleRate            = DDC_Lineup_param.SampleRate/4;                              % output rate at CM  - 122.88 -- 4*30.72
DDC_Lineup_param.RM.No_Of_complex_chan    = 4;
DDC_Lineup_param.RM.No_Of_complex_Freq    = DDC_Lineup_param.total_AxC;

%% Filter 2 - HB5
DDC_Lineup_param.HB_filter5.SampleRate            = DDC_Lineup_param.SampleRate/4;         % Input rate at filter2
DDC_Lineup_param.HB_filter5.FilterLength          = 27;                           % Number of Taps is not doesnt depend on parameter- Filter Lengh. It inherits from Coefficient file.
DDC_Lineup_param.HB_filter5.Decimation            = 2;                           % Decmation rate  
DDC_Lineup_param.HB_filter5.ChanCount             = DDC_Lineup_param.total_AxC*2;
DDC_Lineup_param.HB_filter5.coeff_word_length     = 16;                          % filter2 coefficient: bit width
DDC_Lineup_param.HB_filter5.coeff_fraction_length = 15;                          % filter2 coefficient: fraction width 
DDC_Lineup_param.HB_filter5.base_addr1             = DDC_LINEUP_param.NCO.Sync + 16;                         % filter2 coefficient address map (start)

%% Filter 3 - HB4
DDC_Lineup_param.HB_filter4.SampleRate            = DDC_Lineup_param.SampleRate/8;         % Input rate at filter3
DDC_Lineup_param.HB_filter4.Decimation            = 2;                           % Interpolation rate  
DDC_Lineup_param.HB_filter4.ChanCount             = DDC_Lineup_param.total_AxC*2;
DDC_Lineup_param.HB_filter4.base_addr1            = DDC_Lineup_param.HB_filter5.base_addr1 + 128;   
DDC_Lineup_param.HB_filter4.coeff_word_length     = 16;                          % filter3 coefficient: bit width
DDC_Lineup_param.HB_filter4.coeff_fraction_length = 15;                          % filter3 coefficient: fraction width 
DDC_Lineup_param.HB_filter4.FilterLength          = 47;                           % Number of Taps is not doesnt depend on parameter- Filter Lengh. It inherits from Coefficient file.


%% Filter 6 - Channel Filter
DDC_Lineup_param.CH_filter.SampleRate         = DDC_Lineup_param.SampleRate/16;     
DDC_Lineup_param.CH_filter.FilterLength          = 87; 
DDC_Lineup_param.CH_filter.ChanCount             = DDC_Lineup_param.total_AxC*2;
DDC_Lineup_param.CH_filter.coeff_word_length     = 16;                          % filter6 coefficient: bit width
DDC_Lineup_param.CH_filter.coeff_fraction_length = 15;                          % filter6 coefficient: fraction width 
DDC_Lineup_param.CH_filter.base_addr1            = DDC_Lineup_param.HB_filter4.base_addr1+128;                         



 %%%%%%%%%%%%%%% DC BLOCKER %%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
DDC_LINEUP_param.DC_Blocker_En = DDC_Lineup_param.CH_filter.base_addr1 + 128;
DC_Blocker_Initial_Value = 0; %% 0 --> disable , 1 --> Enable



ddc_in_gain_addr = DDC_LINEUP_param.DC_Blocker_En +1;
carr1_gain_addr = ddc_in_gain_addr + 1;
carr2_gain_addr = carr1_gain_addr + 1;
carr3_gain_addr = carr2_gain_addr + 1;
carr4_gain_addr = carr3_gain_addr + 1;

ddc_in_gain_init_value = 1;

carr1_gain_val_init = 1;

carr2_gain_val_init = 1;

carr3_gain_val_init = 1;

carr4_gain_val_init = 1;

Mixer_Shifter_init_value=0;

power_meter_param.ddc_in_pd_address           = carr4_gain_addr+1;
power_meter_param.ddc1_in_acc1_reg_addr       = power_meter_param.ddc_in_pd_address+1;
power_meter_param.ddc1_in_acc2_reg_addr       = power_meter_param.ddc1_in_acc1_reg_addr+1;


power_meter_param.ddc_carr1_out_pd_address        = power_meter_param.ddc1_in_acc2_reg_addr+1;
power_meter_param.ddc_carr2_out_pd_address        = power_meter_param.ddc_carr1_out_pd_address+1;
power_meter_param.ddc_carr3_out_pd_address        = power_meter_param.ddc_carr2_out_pd_address+1;
power_meter_param.ddc_carr4_out_pd_address        = power_meter_param.ddc_carr3_out_pd_address+1;


power_meter_param.ddc_carr1_out_acc1_reg_addr = power_meter_param.ddc_carr4_out_pd_address+1;
power_meter_param.ddc_carr1_out_acc2_reg_addr = power_meter_param.ddc_carr1_out_acc1_reg_addr+1;

power_meter_param.ddc_carr2_out_acc1_reg_addr = power_meter_param.ddc_carr1_out_acc2_reg_addr+1;
power_meter_param.ddc_carr2_out_acc2_reg_addr = power_meter_param.ddc_carr2_out_acc1_reg_addr+1;

power_meter_param.ddc_carr3_out_acc1_reg_addr = power_meter_param.ddc_carr2_out_acc2_reg_addr+1;
power_meter_param.ddc_carr3_out_acc2_reg_addr = power_meter_param.ddc_carr3_out_acc1_reg_addr+1;

power_meter_param.ddc_carr4_out_acc1_reg_addr = power_meter_param.ddc_carr3_out_acc2_reg_addr+1;
power_meter_param.ddc_carr4_out_acc2_reg_addr = power_meter_param.ddc_carr4_out_acc1_reg_addr+1;

Reg_busy_bit_addr                            = power_meter_param.ddc_carr4_out_acc2_reg_addr+1;
Shifter_Bits                                 = Reg_busy_bit_addr+1;

    
    
    DDC_Lineup_param.chan_filter.coeffs(1,:)  =fi(load(chanfilt_coeff),1,DDC_Lineup_param.CH_filter.coeff_word_length,DDC_Lineup_param.CH_filter.coeff_fraction_length);
    DDC_Lineup_param.HB_filt4.coeffs(1,:)     =fi(load(hb4_coeff),1,DDC_Lineup_param.HB_filter4.coeff_word_length,DDC_Lineup_param.HB_filter4.coeff_fraction_length);
    DDC_Lineup_param.HB_filt5.coeffs(1,:)     =fi(load(hb5_coeff),1,DDC_Lineup_param.HB_filter5.coeff_word_length,DDC_Lineup_param.HB_filter5.coeff_fraction_length);
    DDC_Lineup_param.HB_filt6.coeffs(1,:)     =fi(load(hb6_coeff),1,DDC_Lineup_param.HB_filter6.coeff_word_length,DDC_Lineup_param.HB_filter6.coeff_fraction_length);
    DDC_Lineup_param.HB_filt7.coeffs(1,:)     =fi(load(hb7_coeff),1,DDC_Lineup_param.HB_filter7.coeff_word_length,DDC_Lineup_param.HB_filter7.coeff_fraction_length);

%% Simulation Parameters
DDC_Lineup_param.SampleTime  = 1;                    % One unit in Simulink simulation is one clock cycle 
DDC_Lineup_param.endTime     = 5000*2;                 % How many simulation clock cycles
DDC_Lineup_param.ContiguousValidFrames   = 1;        % Create a sequence of valid and invali frames of stimulus data in the Channelizer block
DDC_Lineup_param.ContiguousInvalidFrames = 0; 


%%%%%%%%%%%%%%%%%%%%%%%%%%%% Real INPUT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


DDC_Lineup_param.Freq = 1;

real_data = 0.2*cos(2*pi*(DDC_Lineup_param.Freq/DDC_Lineup_param.SampleRate)*[0:1:DDC_Lineup_param.endTime]);
imag_data = 0.2*sin(2*pi*(DDC_Lineup_param.Freq/DDC_Lineup_param.SampleRate)*[0:1:DDC_Lineup_param.endTime]);

data_quant=quantizer('fixed','floor','saturate',[16 15]);

real_data_quant=quantize(data_quant,real_data)*2^15;
imag_data_quant=quantize(data_quant,imag_data)*2^15;

%plot(real_data_quant);

DDC_Lineup_param.inputdata1=imag_data_quant*2^16+real_data_quant;

fvtool(complex(DDC_Lineup_param.inputdata1,0),'fs',491.52e6);




%% Derived Parameters 
DDC_Lineup_param.Period          = DDC_Lineup_param.ClockRate / DDC_Lineup_param.SampleRate;           % Clock cycles between consecutive data samples for a particular channel

%% DSPBA Design Parameters End
