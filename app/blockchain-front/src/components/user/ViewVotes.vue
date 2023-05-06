<script setup lang="ts">
import {reactive} from "vue";
import "bootstrap/dist/css/bootstrap.css";
import "bootstrap/dist/js/bootstrap.js";

const rowData: string[] = []
const reactiveData = reactive(rowData)
// Utiliser la méthode de ShowProposal/UserVote pour afficher un tableau avec description du vote et le nombre de votes
</script>

<template>
    <div class="container">
        <div class="row">
            <table class="table" id="myTable">
                <tr v-for="item in reactiveData">
                    <th style="width: 80%;" scope="row" :id="item">{{ item.description }}</th>
                    <td style="width: 20%;"><span>{{ item.voteCount }}</span></td>
                </tr>
            </table>
        </div>
    </div>
</template>

<style scoped>

</style>