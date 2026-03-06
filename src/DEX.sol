import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DEX is ERC20Burnable , ERC20{
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

    function LPAddliquidity(uint256 HCamount ,uint256 YTamount) public {
        require(HCamount*reserveYT == YTamount*reserveHC,"Ratio not Matched");
        HC.transferFrom(msg.sender, address(this), HCamount);
        YT.transferFrom(msg.sender, address(this), YTamount);
        reserveHC += HCamount;
        reserveYT += YTamount;
        // amount = HCamount
        giveLP(msg.sender,amount);
    }

    function AddLiquidity (uint256 HCamount,uint256 YTamount) external {
        require(msg.sender == owner,"Not Allowed");
            HC.transferFrom(msg.sender, address(this), HCamount);
            YT.transferFrom(msg.sender, address(this), YTamount);
            reserveHC += HCamount;
            reserveYT += YTamount;
    }

    function getAmount (uint256 amountIn,uint256 reserveIn,uint256 reserveOut) internal pure returns(uint256){
        uint256 amountOut= (amountIn * reserveOut)/(reserveIn + amountIn);
        return amountOut;
    }

    function SwapYT(uint256 _YT) public {
        require(_YT > 0 ,"0 YT cannot be swapped");
        uint256 amountOut = getAmount(_YT, reserveYT, reserveHC);
        YT.transferFrom(msg.sender,address(this),_YT);
        HC.transfer(msg.sender, amountOut);
        reserveYT += _YT;
        reserveHC -=amountOut;
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