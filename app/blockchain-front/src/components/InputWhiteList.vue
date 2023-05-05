<script setup lang="ts">

import {reactive} from "vue";
import "bootstrap/dist/css/bootstrap.css";
import "bootstrap/dist/js/bootstrap.js";


const rowData: string[] = []
const reactiveData = reactive(rowData)
const add = () => {
    const value = document.querySelector("#addedAddress").value
    if (value != "" && !reactiveData.includes(value)) {
        reactiveData.push(document.querySelector("#addedAddress").value)
    }

}

const startVote = () => {

}

function deleteRow(i) {
    reactiveData.splice(i, 1)
}
</script>

<template>
    <div class="container">
        <div class="row my-4">
            <div class="col-8">
                <label for="addedAddress" class="form-label">Address to register</label>
                <input class="form-control" type="text" id="addedAddress"/>
            </div>
            <div class="col-4 d-grid my-auto">
                <button class="btn btn-primary btn-block buttonSave" id="buttonSave" v-on:click="add">Add to list</button>
            </div>
        </div>
        <div class="row my-4 AddList">
            <table class="table" id="myTable">
                <tr v-for="item in reactiveData">
                    <th style="width: 80%;" scope="row" :id="item">{{ item }}</th>
                    <td style="width: 20%;"><button class="btn btn-outline-danger " v-on:click="deleteRow(reactiveData.indexOf(item))">Delete</button></td>
                </tr>
            </table>
        </div>
        <div class="row justify-content-center">
            <button class="btn btn-primary" v-on:click="startVote">Start vote</button>
        </div>
    </div>
</template>

<style scoped>
</style>