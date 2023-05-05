`timescale 1ns / 1ps
 
module Instruction_Memory
(
	input [63:0] Inst_Address,
	output reg [31:0] Instruction
);
	reg [7:0] inst_mem [207:0];
	
	initial
	begin 
		inst_mem[0]=8'h13;
		inst_mem[1]=8'h05;
		inst_mem[2]=8'h00;
		inst_mem[3]=8'h00;
		
		inst_mem[4]=8'h93;
		inst_mem[5]=8'h02;
		inst_mem[6]=8'h10;
		inst_mem[7]=8'h00;
		
		inst_mem[8]=8'h23;
		inst_mem[9]=8'h30;
		inst_mem[10]=8'h55;
		inst_mem[11]=8'h00;
		
		inst_mem[12]=8'h93;
		inst_mem[13]=8'h02;
		inst_mem[14]=8'h50;
		inst_mem[15]=8'h00;
		
		inst_mem[16]=8'h23;
		inst_mem[17]=8'h34;
		inst_mem[18]=8'h55;
		inst_mem[19]=8'h00;
		
		inst_mem[20]=8'h93;
		inst_mem[21]=8'h02;
		inst_mem[22]=8'h30;
		inst_mem[23]=8'h00;
		
		inst_mem[24]=8'h23;
		inst_mem[25]=8'h38;
		inst_mem[26]=8'h55;
		inst_mem[27]=8'h00;
		
		inst_mem[28]=8'h93;		
		inst_mem[29]=8'h02;
		inst_mem[30]=8'h40;
		inst_mem[31]=8'h00;
		
		inst_mem[32]=8'h23;
		inst_mem[33]=8'h3C;
		inst_mem[34]=8'h55;
		inst_mem[35]=8'h00;
		
		inst_mem[36]=8'h93;
		inst_mem[37]=8'h02;
		inst_mem[38]=8'hA0;
		inst_mem[39]=8'h00;
		
		inst_mem[40]=8'h23;
		inst_mem[41]=8'h30;
		inst_mem[42]=8'h55;
		inst_mem[43]=8'h02;
		
		inst_mem[44]=8'h93;		
		inst_mem[45]=8'h02;
		inst_mem[46]=8'h60;
		inst_mem[47]=8'h01;
		
		inst_mem[48]=8'h23;
		inst_mem[49]=8'h34;
		inst_mem[50]=8'h55;
		inst_mem[51]=8'h02;
		
		inst_mem[52]=8'h93;
		inst_mem[53]=8'h02;
		inst_mem[54]=8'h20;
		inst_mem[55]=8'h00;
		
		inst_mem[56]=8'h23;
		inst_mem[57]=8'h38;
		inst_mem[58]=8'h55;
		inst_mem[59]=8'h02;
		
		inst_mem[60]=8'h93;
		inst_mem[61]=8'h02;
		inst_mem[62]=8'h30;
		inst_mem[63]=8'h00;
		
		inst_mem[64]=8'h23;
		inst_mem[65]=8'h3C;
		inst_mem[66]=8'h55;
		inst_mem[67]=8'h02;
		
		inst_mem[68]=8'h93;
		inst_mem[69]=8'h02;
		inst_mem[70]=8'hC0;
		inst_mem[71]=8'h02;
		
		inst_mem[72]=8'h23;
		inst_mem[73]=8'h30;
		inst_mem[74]=8'h55;
		inst_mem[75]=8'h04;
		
		// SIZE OF ARRAY
		inst_mem[76]=8'h93;
		inst_mem[77]=8'h05;
		inst_mem[78]=8'h90;
		inst_mem[79]=8'h00;
		
		// CALLING THE PROCEDURES USING BEQ
		inst_mem[80]=8'h63;
		inst_mem[81]=8'h04;
		inst_mem[82]=8'h00;
		inst_mem[83]=8'h00;
		
		inst_mem[84]=8'h63;
		inst_mem[85]=8'h08;
		inst_mem[86]=8'h00;
		inst_mem[87]=8'hA0;
		
		// SEL_SORT
		inst_mem[88]=8'h93;
		inst_mem[89]=8'h02;
		inst_mem[90]=8'h00;
		inst_mem[91]=8'h00;
		
		inst_mem[92]=8'h13;
		inst_mem[93]=8'h03;
		inst_mem[94]=8'h00;
		inst_mem[95]=8'h00;
		
		inst_mem[96]=8'h93;
		inst_mem[97]=8'h03;
		inst_mem[98]=8'h00;
		inst_mem[99]=8'h00;
		
		inst_mem[100]=8'h13;
		inst_mem[101]=8'h84;
		inst_mem[102]=8'h05;
		inst_mem[103]=8'h00;
		
		inst_mem[104]=8'h93;
		inst_mem[105]=8'h85;
		inst_mem[106]=8'hF5;
		inst_mem[107]=8'hFF;
		
		// UNSORTED_ARRAY_BOUNDARY_LOOP
		inst_mem[108]=8'h63;
		inst_mem[109]=8'h80;
		inst_mem[110]=8'hb2;
		inst_mem[111]=8'h06;
		
		inst_mem[112]=8'h93;
		inst_mem[113]=8'h83;
		inst_mem[114]=8'h02;
		inst_mem[115]=8'h00;
		
		inst_mem[116]=8'h13;
		inst_mem[117]=8'h83;
		inst_mem[118]=8'h12;
		inst_mem[119]=8'h00;
		
		// SUBARRAY_LOOP
		inst_mem[120]=8'h63;
		inst_mem[121]=8'h06;
		inst_mem[122]=8'h83;
		inst_mem[123]=8'h02;
		
		inst_mem[124]=8'h13;
		inst_mem[125]=8'h1F;
		inst_mem[126]=8'h33;
		inst_mem[127]=8'h00;
		
		inst_mem[128]=8'hB3;
		inst_mem[129]=8'h0F;
		inst_mem[130]=8'hE5;
		inst_mem[131]=8'h01;
		
		inst_mem[132]=8'h83;
		inst_mem[133]=8'hBE;
		inst_mem[134]=8'h0F;
		inst_mem[135]=8'h00;
		
		inst_mem[136]=8'h13;
		inst_mem[137]=8'h9F;
		inst_mem[138]=8'h33;
		inst_mem[139]=8'h00;
		
		inst_mem[140]=8'hB3;
		inst_mem[141]=8'h0F;
		inst_mem[142]=8'hE5;
		inst_mem[143]=8'h01;
		
		inst_mem[144]=8'h03;
		inst_mem[145]=8'hBE;
		inst_mem[146]=8'h0f;
		inst_mem[147]=8'h00;
		
		inst_mem[148]=8'h63;
		inst_mem[149]=8'h44;
		inst_mem[150]=8'hDE;
		inst_mem[151]=8'h01;
		
		inst_mem[152]=8'h93;
		inst_mem[153]=8'h03;
		inst_mem[154]=8'h03;
		inst_mem[155]=8'h00;
		
		// MIN_REMAINS_SAME
		inst_mem[156]=8'h13;
		inst_mem[157]=8'h03;
		inst_mem[158]=8'h13;
		inst_mem[159]=8'h00;
		
		inst_mem[160]=8'he3;
		inst_mem[161]=8'h0c;
		inst_mem[162]=8'h00;
		inst_mem[163]=8'hFc;
		
		// END_SUBARRAY_LOOP
		inst_mem[164]=8'h13;
		inst_mem[165]=8'h9F;
		inst_mem[166]=8'h33;
		inst_mem[167]=8'h00;
		
		inst_mem[168]=8'hB3;
		inst_mem[169]=8'h0F;
		inst_mem[170]=8'hE5;
		inst_mem[171]=8'h01;
		
		inst_mem[172]=8'h03;
		inst_mem[173]=8'hBE;
		inst_mem[174]=8'h0F;
		inst_mem[175]=8'h00;
		
		inst_mem[176]=8'h13;
		inst_mem[177]=8'h93;
		inst_mem[178]=8'h32;
		inst_mem[179]=8'h00;
		
		inst_mem[180]=8'h33;
		inst_mem[181]=8'h03;
		inst_mem[182]=8'hA3;
		inst_mem[183]=8'h00;
		
		inst_mem[184]=8'h83;
		inst_mem[185]=8'h3E;
		inst_mem[186]=8'h03;
		inst_mem[187]=8'h00;
		
		inst_mem[188]=8'h23;
		inst_mem[189]=8'h30;
		inst_mem[190]=8'hc3;
		inst_mem[191]=8'h01;
		
		inst_mem[192]=8'h23;
		inst_mem[193]=8'hB0;
		inst_mem[194]=8'hdF;
		inst_mem[195]=8'h01;
		
		inst_mem[196]=8'h93;
		inst_mem[197]=8'h82;
		inst_mem[198]=8'h12;
		inst_mem[199]=8'h00;
		
		inst_mem[200]=8'he3;
		inst_mem[201]=8'h02;
		inst_mem[202]=8'h00;
		inst_mem[203]=8'hfa;
		
		// END UNSORTED ARRAY BOUNDARY LOOP
		inst_mem[204]=8'h63;
		inst_mem[205]=8'h00;
		inst_mem[206]=8'h00;
		inst_mem[207]=8'h00;
		
	end
	
	
	always @(Inst_Address)
	begin
		Instruction={inst_mem[Inst_Address+3],inst_mem[Inst_Address+2],inst_mem[Inst_Address+1],inst_mem[Inst_Address]};
	end
endmodule
