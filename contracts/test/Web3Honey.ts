import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { expect } from "chai";
import { ethers, upgrades } from "hardhat";

describe("NFT", function () {
  describe("Box", function () {
    it("works", async () => {
      const Web3Honey = await ethers.getContractFactory("Web3Honey");

      const web3Honey = await upgrades.deployProxy(Web3Honey);

      await web3Honey.deployed();
      expect(await web3Honey.getMetadataTypes()).to.equal(12);
    });
  });

  describe("Deployment", function () {
    let signer: SignerWithAddress;
    let mob1: SignerWithAddress;
    let mob2: SignerWithAddress;
    let nft: any;
    beforeEach(async function () {
      [signer, mob1, mob2] = await ethers.getSigners();
      const Web3Honey = await ethers.getContractFactory("Web3Honey");
      nft = await upgrades.deployProxy(Web3Honey);
    });
    
    it("Should mint correctly", async function () {
      const tokenId = "0";
      await nft.connect(signer).mint()
      expect(await nft.ownerOf(tokenId)).to.equal(signer.address);
    });

    it("Should not mint twice", async function () {
      await nft.mint()
      await expect(nft.mint()).to.revertedWith("You cannot mint twice");
    });

    it("setMetadataTypes", async function () {
      console.log(await nft.owner())
      const index = "5"
      await nft.setMetadataTypes(index);
      expect(await nft.getMetadataTypes()).to.equal(index);
    });

    it("setBaseTokenUri", async function () {
      const uri = "https://web3-honey.com";
      await nft.setBaseTokenUri(uri);
      expect(await nft.baseTokenURI()).to.equal(uri);
    });
  });
});
