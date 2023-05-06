<script setup lang="ts">
import {reactive} from "vue";

// Utiliser la méthode de ShowProposal pour afficher un tableau avec description du vote et bouton pour voter
const rowData: string[] = []
const reactiveData = reactive(rowData)

const vote = (proposalId: number) => {

}
</script>

<template>
<div class="container py-2">
    <div class="row">
        <table class="table" id="myTable">
            <tr v-for="item in reactiveData">
                <th style="width: 80%;" scope="row" :id="item">{{ item }}</th>
                <td style="width: 20%;"><button class="btn btn-outline-danger " v-on:click="vote(reactiveData.indexOf(item))">Vote</button></td>
            </tr>
        </table>
    </div>
</div>
</template>

<style scoped>

</style>