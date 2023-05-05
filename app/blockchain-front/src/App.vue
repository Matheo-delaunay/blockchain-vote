<script setup lang="ts">
import Voting from '../../../back/build/contracts/Voting.json'
import {onMounted, reactive, ref} from "vue";
import getWeb3 from './assets/getWeb3.js'
import VotingComponent from "@/components/VotingComponent.vue";
import InputWhiteList from "@/components/WhiteList/InputWhiteList.vue";


let web3var = null
let accountsvar = null
let contractvar = null
let userAddressvar = null
let isOwnervar = false



onMounted(async () => {
    try {
        // Get network provider and web3 instance.
        const web3 = await getWeb3()

        // Use web3 to get the user's accounts.
        /* on récupère le tableau des comptes sur le metamask du user */
        const accounts = await web3.eth.getAccounts()

        // Get the contract instance.
        const networkId = await web3.eth.net.getId()
        const deployedNetwork = Voting.networks[networkId]
        console.log("deployedNetwork", deployedNetwork)
        /* Création de l'objet de contrat avec l'abi, le deployedNetwork et son address  */
        const instance = new web3.eth.Contract(
            Voting.abi,
            deployedNetwork && deployedNetwork.address
        )

        // Set web3, accounts, and contract to the state, and then proceed with an
        // example of interacting with the contract's methods.
        web3var = web3
        accountsvar = accounts
        contractvar = instance
        let account = accountsvar[0]
        userAddressvar = account.slice(0, 6) + "..." + account.slice(38, 42)

        // Check if the user is the owner
        const owner = await instance.methods.owner().call()
        if (account === owner) {
            isOwnervar = true
        }
    } catch (error) {
        // Catch any errors for any of the above operations.
        alert(
            `Failed to load web3, accounts, or contract. Check console for details.`
        )
        console.error(error)
    }
})
let show = null
const active = ()=>{
    show = contractvar
    contractvar.methods.test().call().then((result)=>console.log(result))
}
const startVote = () => {
    contractvar.methods.start
}

</script>

<template>
  <VotingComponent/>
    <input-white-list @startVote="startVote"></input-white-list>


</template>


<style scoped>
</style>
