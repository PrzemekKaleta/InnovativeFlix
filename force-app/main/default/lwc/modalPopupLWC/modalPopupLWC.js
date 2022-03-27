import { LightningElement,track, api} from 'lwc';
export default class ModalPopupLWC extends LightningElement {

    @api season;
    @api tvSerieName;

    @track isModalOpen = false;
    openModal() {
        this.isModalOpen = true;
    }
    closeModal() {

        this.isModalOpen = false;
    }

}