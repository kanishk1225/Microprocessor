module alu_8mod(out,a,b,s);

input [8:0]a,b;

input [3:0]s;

output [8:0]out;

reg [8:0]out;

wire in1,in2;
//,flag;

always@(s)

begin

case(s)

4'b0000:           out=a+b;                 //8-bit addition

4'b0001:           out=a-b;                  //8-bit subtraction

4'b0010:           out=a*b;                 //8-bit multiplication

4'b0011:           out=a/b;                  //8-bit division

4'b0100:           out=in1%in2;                //8-bit modulo division

4'b0101:           out=in1&&in2; //8-bit logical and

4'b0110:           out=a||b;                  //8-bit logical or

4'b0111:           out=!a;                      //8-bit logical negation

4'b1000:           out=~a;                     //8-bit bitwise negation

4'b1001:           out=a&b;                //8-bit bitwise and

4'b1010:           out=a|b;                  //8-bit bitwise or

4'b1011:           out=a^b;                 //8-bit bitwise xor

4'b1100:           out=a<<1;                 //left shift

4'b1101:           out=a>>1;                 //right shift

4'b1110:           out=a+1;                   //increment

4'b1111:           out=a-1;                    //decrement

endcase

end

 

endmodule