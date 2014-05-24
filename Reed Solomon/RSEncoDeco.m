function [decodedBlockStream,SyndromeCodeWordStream] = RSEncoDeco(A1)

decodedBlockStream='';
decodedBlockStreamArray=0;
SyndromeCodeWordStream ='';
SyndromeCodeWordErroredCompression = '';

ReedSolomonLookUpTable = {
       '54 44'         '60 43'        '11 6'         '28 48'        '6 8'          '1 0'          '0 1'       
       '31 43'        '11 37'        '22 12'        '56 19'        '12 16'        '2 0'          '0 2'       
       '41 7'         '55 14'        '29 10'        '36 35'        '10 24'        '3 0'          '0 3'       
       '62 37'        '22 57'        '44 24'        '3 38'         '24 32'        '4 0'          '0 4'       
       '8 9'          '42 18'        '39 30'        '31 22'        '30 40'        '5 0'          '0 5'       
       '33 14'        '29 28'        '58 20'        '59 53'        '20 48'        '6 0'          '0 6'       
       '23 34'        '33 55'        '49 18'        '39 5'         '18 56'        '7 0'          '0 7'       
       '15 57'        '44 1'         '43 48'        '6 63'         '48 51'        '8 0'          '0 8'       
       '57 21'        '16 42'        '32 54'        '26 15'        '54 59'        '9 0'          '0 9'       
      '16 18'        '39 36'        '61 60'        '62 44'        '60 35'        '10 0'         '0 10'       
      '38 62'        '27 15'        '54 58'        '34 28'        '58 43'        '11 0'         '0 11'       
      '49 28'        '58 56'        '7 40'         '5 25'         '40 19'        '12 0'         '0 12'       
      '7 48'         '6 19'         '12 46'        '25 41'        '46 27'        '13 0'         '0 13'       
      '46 55'        '49 29'        '17 36'        '61 10'        '36 3'         '14 0'         '0 14'       
      '24 27'        '13 54'        '26 34'        '33 58'        '34 11'        '15 0'         '0 15'       
      '30 1'         '43 2'         '37 19'        '12 13'        '19 21'        '16 0'         '0 16'       
      '40 45'        '23 41'        '46 21'        '16 61'        '21 29'        '17 0'         '0 17'       
      '1 42'         '32 39'        '51 31'        '52 30'        '31 5'         '18 0'         '0 18'       
      '55 6'         '28 12'        '56 25'        '40 46'        '25 13'        '19 0'         '0 19'       
      '32 36'        '61 59'        '9 11'         '15 43'        '11 53'        '20 0'         '0 20'       
      '22 8'         '1 16'         '2 13'         '19 27'        '13 61'        '21 0'         '0 21'       
      '63 15'        '54 30'        '31 7'         '55 56'        '7 37'         '22 0'         '0 22'       
      '9 35'         '10 53'        '20 1'         '43 8'         '1 45'         '23 0'         '0 23'       
      '17 56'        '7 3'          '14 35'        '10 50'        '35 38'        '24 0'         '0 24'       
      '39 20'        '59 40'        '5 37'         '22 2'         '37 46'        '25 0'         '0 25'       
      '14 19'        '12 38'        '24 47'        '50 33'        '47 54'        '26 0'         '0 26'       
      '56 63'        '48 13'        '19 41'        '46 17'        '41 62'        '27 0'         '0 27'       
      '47 29'        '17 58'        '34 59'        '9 20'         '59 6'         '28 0'         '0 28'       
      '25 49'        '45 17'        '41 61'        '21 36'        '61 14'        '29 0'         '0 29'       
      '48 54'        '26 31'        '52 55'        '49 7'         '55 22'        '30 0'         '0 30'       
      '6 26'         '38 52'        '63 49'        '45 55'        '49 30'        '31 0'         '0 31'       
      '60 2'         '37 4'         '57 38'        '24 26'        '38 42'        '32 0'         '0 32'       
      '10 46'        '25 47'        '50 32'        '4 42'         '32 34'        '33 0'         '0 33'       
      '35 41'        '46 33'        '47 42'        '32 9'         '42 58'        '34 0'         '0 34'       
      '21 5'         '18 10'        '36 44'        '60 57'        '44 50'        '35 0'         '0 35'       
      '2 39'         '51 61'        '21 62'        '27 60'        '62 10'        '36 0'         '0 36'       
      '52 11'        '15 22'        '30 56'        '7 12'         '56 2'         '37 0'         '0 37'       
      '29 12'        '56 24'        '3 50'         '35 47'        '50 26'        '38 0'         '0 38'       
      '43 32'        '4 51'         '8 52'         '63 31'        '52 18'        '39 0'         '0 39'       
      '51 59'        '9 5'          '18 22'        '30 37'        '22 25'        '40 0'         '0 40'       
      '5 23'         '53 46'        '25 16'        '2 21'         '16 17'        '41 0'         '0 41'       
      '44 16'        '2 32'         '4 26'         '38 54'        '26 9'         '42 0'         '0 42'       
      '26 60'        '62 11'        '15 28'        '58 6'         '28 1'         '43 0'         '0 43'       
      '13 30'        '31 60'        '62 14'        '29 3'         '14 57'        '44 0'         '0 44'       
      '59 50'        '35 23'        '53 8'         '1 51'         '8 49'         '45 0'         '0 45'       
      '18 53'        '20 25'        '40 2'         '37 16'        '2 41'         '46 0'         '0 46'       
      '36 25'        '40 50'        '35 4'         '57 32'        '4 33'         '47 0'         '0 47'       
      '34 3'         '14 6'         '28 53'        '20 23'        '53 63'        '48 0'         '0 48'       
      '20 47'        '50 45'        '23 51'        '8 39'         '51 55'        '49 0'         '0 49'       
      '61 40'        '5 35'         '10 57'        '44 4'         '57 47'        '50 0'         '0 50'       
      '11 4'         '57 8'         '1 63'         '48 52'        '63 39'        '51 0'         '0 51'       
      '28 38'        '24 63'        '48 45'        '23 49'        '45 31'        '52 0'         '0 52'       
      '42 10'        '36 20'        '59 43'        '11 1'         '43 23'        '53 0'         '0 53'       
      '3 13'         '19 26'        '38 33'        '47 34'        '33 15'        '54 0'         '0 54'       
      '53 33'        '47 49'        '45 39'        '51 18'        '39 7'         '55 0'         '0 55'       
      '45 58'        '34 7'         '55 5'         '18 40'        '5 12'         '56 0'         '0 56'       
      '27 22'        '30 44'        '60 3'         '14 24'        '3 4'          '57 0'         '0 57'       
      '50 17'        '41 34'        '33 9'         '42 59'        '9 28'         '58 0'         '0 58'       
      '4 61'         '21 9'         '42 15'        '54 11'        '15 20'        '59 0'         '0 59'       
      '19 31'        '52 62'        '27 29'        '17 14'        '29 44'        '60 0'         '0 60'       
      '37 51'        '8 21'         '16 27'        '13 62'        '27 36'        '61 0'         '0 61'       
      '12 52'        '63 27'        '13 17'        '41 29'        '17 60'        '62 0'         '0 62'       
      '58 24'        '3 48'         '6 23'         '53 45'        '23 52'        '63 0'         '0 63'       

};


%% %%%%%%%%%%%%%%%%%%%%%%%%%%% Generator Polynomail%%%%%%%%%%%%%%%%%%%%

%% Galois Field GF(2^6) = GF(64) based on P(x) = x6 + x5 + x4 + x + 1

polyBinary =  gfrepcov([6 5 4 1 0]);
gfFeildNumber = bin2dec(num2str(fliplr(polyBinary)));
GeneratorField= gf([2], 6, gfFeildNumber);

%% GeneratorFieldCofficients = GF(2^6) array. Primitive polynomial = D^6+D^5+D^4+D+1 (115 decimal)

GeneratorFieldCofficients = GeneratorField .^ [0:62];

%% Getting Generator polynomial cofficients from GeneratorFieldCofficients
GX = rsgenpoly( 63, 61, gfFeildNumber);

warning('off','comm:obsolete:rsenc')
for index = 1 : 30 : length(A1)-30
    
   thirtyBit = A1(index: index +29);
   coIndex = 1 ;
   FX = 0;
        
   for index1 = 1 : 6 : length(thirtyBit)-5
        cofficients = thirtyBit(index1 : index1+5) ;
        FX(coIndex) = bin2dec(cofficients);
        coIndex = coIndex + 1;
   end
   FX;
   coIndex = 0;  
   %% Appendng Parity bits to our codeword
   
   FXAppended = gf( FX ,6,gfFeildNumber);
   SyndromeCodeWord = rsenc( FXAppended, 7, 5, GX);
   SyndromeCodeWordIntArray = double(SyndromeCodeWord.x);
   
   %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Intorduce error %%%%%%%%%%%%%%%%%%%%%
   
   %% Creating Error and SyndromeCodeWordErrored is codeword received at reciever end
   x = floor(1 + (7-1) * rand);
   
   mini = SyndromeCodeWordIntArray(x);
   maxi = 63;
   errorNumber = floor(mini + (maxi-mini) * rand);
   if(mini == 63)
        x = floor(1 + (7-1) * rand);
        errorNumber = 1;
   end
   if(errorNumber == 0)
       errorNumber = 1;
   end
   errorEncodingArray = [0 0 0 0 0 0 0];
   errorEncodingArray(x) = errorNumber ;
   
   
   error = gf( errorEncodingArray,6,gfFeildNumber) ;
   SyndromeCodeWordErrored = SyndromeCodeWord + error ;

    
   %% creating bitStream for error image(This section is just for Error image creation) please ignore.
   SyndromeCodeWordErroredIntArray = double(SyndromeCodeWordErrored.x);
   SyndromeCodeWordStreamArray=0;
   SyndromeCodeWordStream1 = '0';
   
   if(size(dec2bin(max(SyndromeCodeWordErroredIntArray)),2) < 6)
       for i = 1 :1 :5
           sizeBinary = size(dec2bin(SyndromeCodeWordErroredIntArray(i)),2);
           if( sizeBinary< 6)
               padZerosNumber = 6 - sizeBinary;
               non6 = strcat(num2str(zeros(1,padZerosNumber)),dec2bin(SyndromeCodeWordErroredIntArray(i)));
               SyndromeCodeWordStream1 = strcat(SyndromeCodeWordStream1,strcat(num2str(zeros(1,padZerosNumber)),dec2bin(SyndromeCodeWordErroredIntArray(i))));
           else
               
               as6 = dec2bin(SyndromeCodeWordErroredIntArray(i));
               SyndromeCodeWordStream1 = strcat(SyndromeCodeWordStream1,dec2bin(SyndromeCodeWordErroredIntArray(i)));
           end
       end
       SyndromeCodeWordStream1 = strrep(SyndromeCodeWordStream1,' ','');
       SyndromeCodeWordStream1 = SyndromeCodeWordStream1(2:31);
       
       
   else
       SyndromeCodeWordStreamArray = dec2bin(SyndromeCodeWordErroredIntArray);
       SyndromeCodeWordStream1 = strcat (SyndromeCodeWordStreamArray(1,:),'',SyndromeCodeWordStreamArray(2,:),'',SyndromeCodeWordStreamArray(3,:),'',...
                                        SyndromeCodeWordStreamArray(4,:),'',SyndromeCodeWordStreamArray(5,:));
       
   end

   SyndromeCodeWordStream = strcat(SyndromeCodeWordStream,SyndromeCodeWordStream1) ;                   

   
   
   %% %%%%%%%%%%%%% Error Introduction Done and Decoding End %%%%%%%%%%%%%%%%
   
   [quotient, remainder ] = deconv(SyndromeCodeWordErrored,GX);
   
   remainderIntArray = double(remainder.x);
   rem1 =  remainderIntArray(6);
   rem2 = remainderIntArray(7);
   remainderToLookUp = strcat(num2str(remainderIntArray(6)),{' '},num2str(remainderIntArray(7)));
   positionInLookUpTable = strmatch(remainderToLookUp,ReedSolomonLookUpTable);
   positionInLookUpTable;
   
   numToMatch = strcat(num2str(remainderIntArray(6)),num2str(remainderIntArray(7)));
   
   numToMatch;
   
   if(size(positionInLookUpTable,1) > 1)
        for u = 1 : 1 : size(positionInLookUpTable)
            t = strrep(ReedSolomonLookUpTable(positionInLookUpTable(u)),' ','');
            t = t{1};
            len1 = length(t);
            len2 = length(numToMatch);
            
            if(length((t)) == length(numToMatch))
            % if(str2num(t) == numToMatch)    
                    positionInLookUpTable = positionInLookUpTable(u);
                break;
            end
        end
   end
   
  y = positionInLookUpTable;
   
   galiosPolyDegree = 0;
   galiosPolyDiffNumber = 0;
   
   if(floor(positionInLookUpTable/63) >= 1)
        galiosPolyDegree = 6 - floor(positionInLookUpTable/63);
        galiosPolyDiffNumber = positionInLookUpTable - floor(positionInLookUpTable/63)*63;
       if(size(galiosPolyDiffNumber,1) > 1)
           galiosPolyDiffNumber = galiosPolyDiffNumber(1);
           galiosPolyDegree = galiosPolyDegree(1);
       end 
      
       if(galiosPolyDiffNumber == 0)
            galiosPolyDiffNumber = 63;
       end
   else
       galiosPolyDegree = 6;
       galiosPolyDiffNumber = positionInLookUpTable;
   end
   
   
   galiosPolyDegree;
   galiosPolyDiffNumber;
   if(size(galiosPolyDiffNumber,2)==0)
        galiosPolyDiffNumber = 0;
   end
  
%% Decoding Original Codeword by creating GF poly for diff and adding it to Received Codeword

errorArray = [0 0 0 0 0 0 0];
errorArray(galiosPolyDegree + 1) = galiosPolyDiffNumber ;
errorArray = fliplr(errorArray);
errorPoly = gf( errorArray,6,gfFeildNumber);

DecodedBCCodeWord = SyndromeCodeWordErrored - errorPoly;
DecodedBCCodeWordIntArray = double(DecodedBCCodeWord.x);


%% Check if all numbers have bitsize < 6 
decodedBlockStreamArray=0;
decodedBlockStream1 = '0';
if(size(dec2bin(max(DecodedBCCodeWordIntArray)),2) < 6)
    for i = 1 :1 :5
        sizeBinary = size(dec2bin(DecodedBCCodeWordIntArray(i)),2);
        if( sizeBinary< 6)
            padZerosNumber = 6 - sizeBinary;
            non6 = strcat(num2str(zeros(1,padZerosNumber)),dec2bin(DecodedBCCodeWordIntArray(i)));
            decodedBlockStream1 = strcat(decodedBlockStream1,strcat(num2str(zeros(1,padZerosNumber)),dec2bin(DecodedBCCodeWordIntArray(i))));
        else
            
            as6 = dec2bin(DecodedBCCodeWordIntArray(i));
            decodedBlockStream1 = strcat(decodedBlockStream1,dec2bin(DecodedBCCodeWordIntArray(i)));
        end
    end
    decodedBlockStream1 = strrep(decodedBlockStream1,' ','');
    decodedBlockStream1 = decodedBlockStream1(2:31);
    
    
else
    decodedBlockStreamArray = dec2bin(DecodedBCCodeWordIntArray);
    decodedBlockStream1 = strcat (decodedBlockStreamArray(1,:),'',decodedBlockStreamArray(2,:),'',decodedBlockStreamArray(3,:),'',...
                        decodedBlockStreamArray(4,:),'',decodedBlockStreamArray(5,:));
   
end

if(strcmp(decodedBlockStream1,thirtyBit) == 1)
else
    'no'  
    FX
    errorEncodingArray
    numToMatch
    t
    thirtyBit
    decodedBlockStream1
    
end

decodedBlockStream = strcat(decodedBlockStream,decodedBlockStream1) ;                   
                                   
  % pause(3);
   
   p = A1(index+30:length(A1));
   if(length(p)<29)
        p;
   end
      
end

end