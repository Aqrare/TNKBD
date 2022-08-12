// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Web3Honey is Initializable,  OwnableUpgradeable, ERC721Upgradeable, ERC721URIStorageUpgradeable  {
    // constructor(){
    //   initialize();
    // }

    uint32 _tokenCount;
    uint32 private _metadataTypes;
    string public baseTokenUri;

    mapping(address => bool) isMinted;

    function initialize() public initializer {
      __Web3Honey_init();
    }

    function __Web3Honey_init() internal onlyInitializing {
      _tokenCount = 0;
      _metadataTypes = 12;
      baseTokenUri = "ipfs://QmWnGToAucoNRdwzfo3opDTUUvUgiVc5q4mdqraYbeTjt7/";
    __Ownable_init_unchained();
    __ERC721_init_unchained("web3honey's POF", "HONEY");
      
    }

    function mint() public {
        require(!isMinted[msg.sender], "You cannot mint twice");
        uint random = uint(keccak256(abi.encodePacked(msg.sender, _tokenCount)));
        string memory id = Strings.toString(random % _metadataTypes + 1);
        bytes memory uri = abi.encodePacked(baseTokenUri, id);
        _safeMint(msg.sender, _tokenCount);
        isMinted[msg.sender] = true;
        _setTokenURI(_tokenCount, string(uri));
        ++_tokenCount;
    }

    function setMetadataTypes(uint32 number) public onlyOwner {
      _metadataTypes = number;
    }

    function setBaseTokenUri(string memory  uri) public onlyOwner {
      baseTokenUri = uri;
    }

    function tokenURI(uint256 tokenId)
    public
    view
    virtual
    override(ERC721Upgradeable, ERC721URIStorageUpgradeable)
    returns (string memory)
  {
    return super.tokenURI(tokenId);
  }

  function baseTokenURI()
  public view returns(string memory) {
    return baseTokenUri;
  }

  function getMetadataTypes()
  public view returns(uint) {
    return _metadataTypes;
  }

  function _burn(uint256 tokenId) internal virtual override(ERC721Upgradeable, ERC721URIStorageUpgradeable) {
    return super._burn(tokenId);
  }
}