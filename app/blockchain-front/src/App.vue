<script setup lang="ts">
import Voting from '../../../back/build/contracts/Voting.json'
import {onMounted, ref} from "vue";
import getWeb3 from './assets/getWeb3.js'
import InputWhiteList from "@/components/admin/InputWhiteList.vue";
import ShowProposal from "@/components/admin/ShowProposal.vue";
import StartVote from "@/components/admin/StartVote.vue";
import FinishVote from "@/components/admin/FinishVote.vue";
import TallyVote from "@/components/admin/TallyVote.vue";
import AddProposal from "@/components/user/AddProposal.vue";
import Navbar from "@/components/Navbar.vue";


const web3var = ref(null)
const accountsvar = ref(null)
const contractvar = ref(null)
const userAddressvar = ref(null)
const isOwnervar = ref(false)



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
        web3var.value = web3
        accountsvar.value = accounts
        contractvar.value = instance
        let account = accountsvar.value[0]
        userAddressvar.value = account.slice(0, 6) + "..." + account.slice(38, 42)

        // Check if the user is the owner
        const owner = await instance.methods.owner().call()
        if (account === owner) {
            isOwnervar.value = true
        }
    } catch (error) {
        // Catch any errors for any of the above operations.
        alert(
            `Failed to load web3, accounts, or contract. Check console for details.`
        )
        console.error(error)
    }
})
const startProposal = (reactiveData:string[]) => {
    contractvar.value.methods.proposals().call((err,res)=>{console.log(res)}).then((result)=>console.log(result))
    //contractvar.value.methods.registerVoters(reactiveData).send({from: accountsvar.value[0]}).then((result)=>console.log(result))
    //contractvar.value.methods.startProposalsRegistration().send({from: accountsvar.value[0]}).then((result)=>console.log(result))

}

const endProposal = () => {
    contractvar.value.methods.endProposalsRegistration().send({from: accountsvar.value[0]}).then((result)=>console.log(result))
}

</script>

<template>
    <navbar :useradress="userAddressvar"></navbar>
    <input-white-list @startProposal="startProposal"></input-white-list>
    <show-proposal></show-proposal>
    <start-vote></start-vote>
    <finish-vote></finish-vote>
    <tally-vote></tally-vote>
    <add-proposal></add-proposal>
</template>


<style scoped>
</style>
