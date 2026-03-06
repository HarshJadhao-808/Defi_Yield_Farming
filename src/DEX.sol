import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DEX is ERC20Burnable {
   uint256 public reserveHC;
   uint256 public reserveYT;
   address private owner;
   
    IERC20 public HC;
    IERC20 public YT;

    constructor(address _HC,address _YT) ERC20("LPtoken","LPT"){
       HC = IERC20(_HC);
       YT = IERC20(_YT);
       owner = msg.sender;
    }

    function giveLP (address account , uint256 LP) private {
        _mint(account,LP);
    }

    function SquareRoot (uint256 x) private pure returns(uint256) {
         uint256 z = (x+1)/2;
         uint256 y = x;

         while(z<y){
            y=z;
            z=(x/z + z)/2;
         }
         return y;
    }

    function AddLiquidity (uint256 HCamount,uint256 YTamount) public {
        if(reserveHC ==0 && reserveYT == 0){
        require(msg.sender == owner,"Not Allowed");
            HC.transferFrom(msg.sender, address(this), HCamount);
            YT.transferFrom(msg.sender, address(this), YTamount);
            uint256 liquidity = SquareRoot(HCamount*YTamount);
            giveLP(owner, liquidity);
            reserveHC += HCamount;
            reserveYT += YTamount;
        }else{
        require(HCamount*reserveYT == YTamount*reserveHC,"Ratio not Matched");
            HC.transferFrom(msg.sender, address(this), HCamount);
            YT.transferFrom(msg.sender, address(this), YTamount);
            uint256 liquidity = (HCamount*totalSupply()) / reserveHC;
            reserveHC += HCamount;
            reserveYT += YTamount;
            giveLP(msg.sender,liquidity);
        }
    }
    function removeLiquidity(uint256 LP) public {
        require(LP>0,"0 LP cannot be buned");
        require(balanceOf(msg.sender)>=LP,"0 LP cannot be buned");
        uint256 amountHC = LP*reserveHC/totalSupply();
        uint256 amountYT = LP*reserveYT/totalSupply();
        _burn(msg.sender, LP);
        reserveHC -= amountHC;
        reserveYT -= amountYT;
        HC.transfer(msg.sender, amountHC);
        YT.transfer(msg.sender, amountYT);
    }

    function getAmount (uint256 amountIn,uint256 reserveIn,uint256 reserveOut) internal pure returns(uint256){
        uint256 feesRemoved = amountIn-(5*amountIn/1000);
        uint256 amountOut= (feesRemoved * reserveOut)/(reserveIn + feesRemoved);
        return amountOut;
    }

    function SwapYT(uint256 _YT) public {
        require(_YT > 0 ,"0 YT cannot be swapped");
        uint256 amountOut = getAmount(_YT, reserveYT, reserveHC);
        YT.transferFrom(msg.sender,address(this),_YT);
        HC.transfer(msg.sender, amountOut);
        reserveYT += _YT;
        reserveHC -= amountOut;
    }

    function swapHC(uint256 _HC) public {
        require(_HC > 0 ,"0 HC cannot be swapped");
        uint256 amountOut = getAmount(_HC, reserveHC, reserveYT);
        HC.transferFrom(msg.sender,address(this),_HC);
        YT.transfer(msg.sender, amountOut);
        reserveHC +=_HC;
        reserveYT -= amountOut;
    }
}