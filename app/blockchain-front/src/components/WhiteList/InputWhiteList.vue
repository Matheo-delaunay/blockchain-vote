<script setup lang="ts">

import {reactive} from "vue";


const rowData: string[] = []
const reactiveData = reactive(rowData)
const add= ()=>{
    const value = document.querySelector("#addedAddress").value
    if(value != "" && !reactiveData.includes(value)){
        reactiveData.push(document.querySelector("#addedAddress").value)
    }

}

const startVote = ()=>{

}
function deleteRow(i){
    reactiveData.splice(i,1)
}
</script>

<template>
<input type="text" id="addedAddress"/>
    <button class="buttonSave" id="buttonSave" v-on:click="add">add</button>
  <div class="AddList">
      <table id="myTable">
          <tr v-for="item in reactiveData">
              <th :id="item">{{ item }}</th>
              <td><input type="button" value="Delete" v-on:click="deleteRow(reactiveData.indexOf(item))"></td>
          </tr>
      </table>
  </div>
  <div>
      <button v-on:click="startVote">start vote</button>
  </div>
</template>

<style scoped>
</style>