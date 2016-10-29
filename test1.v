module alu_8bit(out,a,b,s);

	input [7:0]a,b;
	input [1:0]s;
	output [7:0]out;

	reg [7:0]out;
	reg mul;

	always@(s)
		begin
			case(s)
			2′b00:        adder(out,a,b);          
			2′b01:        out=a&b;                	
			2′b10:        out=a^b;                 
			2′b11:        out=a*b;                 
			endcase
		end
		
endmodule


module adder8bit(out,a,b);
	output [7:0]out;
	input [7:0]a;
	input [7:0]b;
	
	reg [7:0]out;
	reg [7:0]c;
	
	integer cin=0;
	fa FA0(out[0],c[0],a[0],b[0],cin);
	fa FA1(out[1],c[1],a[1],b[1],c[0]);
	fa FA2(out[2],c[2],a[2],b[2],c[1]);
	fa FA3(out[3],c[3],a[3],b[3],c[2]);
	fa FA4(out[4],c[4],a[4],b[4],c[3]);
	fa FA5(out[5],c[5],a[5],b[5],c[4]);
	fa FA6(out[6],c[6],a[6],b[6],c[5]);
	fa FA7(out[7],c[7],a[7],b[7],c[6]);
	
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

module mul8bit(out,a,b);
	output [7:0]out;
	input [7:0]a;
	input [7:0]b;
	
	reg [7:0]out;
	
	
	
endmodule

module multiplier(prod, busy, mc, mp, clk, start);
	output [15:0] prod;
	output busy;
	input [7:0] mc, mp;
	input clk, start;
	reg [7:0] A, Q, M;
	reg Q_1;
	reg [3:0] count;
	wire [7:0] sum, difference;
	
	always @(posedge clk)
	begin
		if (start) begin
			A <= 8'b0;
			M <= mc;
			Q <= mp;
			Q_1 <= 1'b0;
			count <= 4'b0;
		end
		else begin
			case ({Q[0], Q_1})
			2'b0_1 : {A, Q, Q_1} <= {sum[7], sum, Q};
			2'b1_0 : {A, Q, Q_1} <= {difference[7], difference, Q};
			default: {A, Q, Q_1} <= {A[7], A, Q};
			endcase
			count <= count + 1'b1;
		end
	
	end
	
	alu adder (sum, A, M, 1'b0);
	alu subtracter (difference, A, ~M, 1'b1);
	assign prod = {A, Q};
	assign busy = (count < 8);
	
endmodule
	
	
	//The following is an alu.
	//It is an adder, but capable of subtraction:
	//Recall that subtraction means adding the two's complement--
	//a - b = a + (-b) = a + (inverted b + 1)
	//The 1 will be coming in as cin (carry-in)
module alu(out, a, b, cin);
	output [7:0] out;
	input [7:0] a;
	input [7:0] b;
	input cin;
	
	assign out = a + b + cin;

endmodule








/*


module testbench;
	reg clk, start;
	reg [7:0] a, b;
	wire [15:0] ab;
	wire busy;
	
	multiplier multiplier1(ab, busy, a, b, clk, start);
		initial begin
			clk = 0;
			$display("first example: a = 3 b = 17");
			a = 3; b = 17; start = 1; #50 start = 0;
			#80 $display("first example done");
			$display("second example: a = 7 b = 7");
			a = 7; b = 7; start = 1; #50 start = 0;
			#80 $display("second example done");
			$finish;
		end
		
	always #5 clk = !clk;
	always @(posedge clk) $strobe("ab: %d busy: %d at time=%t", ab, busy, $stime);
	
endmodule
*/





