`timescale 1ns / 1ps


module third(Out,A,B,Sel);
	output [7:0] Out;
	input [7:0] A, B;
	input [1:0] Sel;
	reg [7:0] A_1, B_1, Out_1;
	reg [1:0]Sel_1;

	wire [6:0] Carry;
	wire ovr;
	
	initial
	begin
		Sel_1 = 00;
	end
	
	if (Sel_1=="00")
	begin
		if (A_1[0]=="0" && B_1[0]=="0")
		begin
			integer t = 0;
			fa FA1(Out_1[7],Carry[6],A[7],B[7],t);
			fa FA2(Out_1[6],Carry[5],A[6],B[6],Carry[6]);
			fa FA3(Out_1[5],Carry[4],A[5],B[5],Carry[5]);
			fa FA4(Out_1[4],Carry[3],A[4],B[4],Carry[4]);
			fa FA5(Out_1[3],Carry[2],A[3],B[3],Carry[3]);
			fa FA6(Out_1[2],Carry[1],A[2],B[2],Carry[2]);
			fa FA7(Out_1[1],Carry[0],A[1],B[1],Carry[1]);
		end
	end
	
	
	
	
endmodule

module fa(s,co,a,b,ci);
    output s,co;
    input a,b,ci;
    xor1 u1(s,a,b,ci);
    and1 u2(n1,a,b);
    and1 u3(n2,b,ci);
    and1 u4(n3,a,ci);
    or1 u5(co,n1,n2,n3);
endmodule